require 'rails_helper'

RSpec.describe ExtractPackageDetailsWorker do
  describe '#perform' do
    let(:fetcher) { double(:fetcher) }
    let(:parser) { double(:parser) }
    let(:saver) { double(:saver) }
    let(:text_data) { 'xxx' }
    let(:index_data) { { name: 'aaa' } }
    let(:details_data) { { title: 'bbb' } }

    subject { described_class.new.perform(index_data) }
    it do
      expect(PackageDetailsFetcher).to receive(:new).with(data: index_data) { fetcher }
      expect(fetcher).to receive(:call).with(no_args) { text_data }

      expect(PackageDetailsParser).to receive(:new).with(data: text_data) { parser }
      expect(parser).to receive(:call).with(no_args) { details_data }

      expect(PackageDetailsSaver).to receive(:new).with(index_data: index_data, details_data: details_data) { saver }
      expect(saver).to receive(:call).with(no_args)

      subject
    end
  end
end
