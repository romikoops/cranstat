require 'rails_helper'

RSpec.describe PackageListParser do
  describe '#call' do
    context 'when data present' do
      let(:index_data) do
        "Package: A3\n" \
        "Version: 1.0.0\n" \
        "Depends: R (>= 2.15.0), xtable, pbapply\n" \
        "Suggests: randomForest, e1071\n" \
        "License: GPL (>= 2)\n" \
        "NeedsCompilation: no\n" \
        "\n" \
        "Package: abbyyR\n" \
        "Version: 0.5.1\n" \
        "Depends: R (>= 3.2.0)\n" \
        "Imports: httr, XML, curl, readr, plyr, progress\n" \
        ":Suggests: testthat, rmarkdown, knitr (>= 1.11)\n" \
        "License: MIT + file LICENSE\n" \
        "NeedsCompilation: no\n"
      end

      let(:package1_data) do
        {
          'Package' => 'A3',
          'Version' => '1.0.0',
          'Depends' => 'R (>= 2.15.0), xtable, pbapply',
          'Suggests' => 'randomForest, e1071',
          'License' => 'GPL (>= 2)',
          'NeedsCompilation' => 'no'
        }
      end

      let(:package2_data) do
        {
          'Package' => 'abbyyR',
          'Version' => '0.5.1',
          'Depends' => 'R (>= 3.2.0)',
          'Imports' => 'httr, XML, curl, readr, plyr, progress :Suggests: testthat, rmarkdown, knitr (>= 1.11)',
          'License' => 'MIT + file LICENSE',
          'NeedsCompilation' => 'no'
        }
      end

      context 'when default limit' do
        let(:parser) { described_class.new(data: index_data) }
        it { expect(parser.call).to eq([package1_data, package2_data]) }
      end

      context 'when positive limit' do
        let(:parser) { described_class.new(data: index_data, limit: 1) }
        it { expect(parser.call).to eq([package1_data]) }
      end

      context 'when limit is zero' do
        let(:parser) { described_class.new(data: index_data, limit: 0) }
        it { expect(parser.call).to eq([package1_data, package2_data]) }
      end

      context 'when negative limit' do
        let(:parser) { described_class.new(data: index_data, limit: -1) }
        it { expect(parser.call).to eq([package1_data, package2_data]) }
      end
    end

    context 'when data blank' do
      let(:parser) { described_class.new }
      it { expect(parser.call).to eq([]) }
    end
  end
end
