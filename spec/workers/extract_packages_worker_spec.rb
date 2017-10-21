require 'rails_helper'

RSpec.describe ExtractPackagesWorker do
  describe '#perform' do
    let(:fetcher) { double(:fetcher) }
    let(:parser) { double(:parser) }
    let(:text_data) { 'xxx' }
    let(:index_data) { [{ name: 'aaa' }] }

    subject { described_class.new.perform }
    it do
      expect(PackageListFetcher).to receive(:new).with(no_args) { fetcher }
      expect(fetcher).to receive(:call).with(no_args) { text_data }

      expect(PackageListParser).to receive(:new).with(data: text_data, limit: 50) { parser }
      expect(parser).to receive(:call).with(no_args) { index_data }

      expect(ExtractPackageDetailsWorker).to receive(:perform_async).with(index_data.first)

      subject
    end
  end
end
