require 'rails_helper'

RSpec.describe PackageDetailsFetcher do
  describe '#call' do
    let(:fetcher) { described_class.new(data: index_data) }
    let(:index_data) do
      {
        'Package' => 'shape',
        'Version' => '1.4.3',
        'Depends' => 'R (>= 2.01)',
        'Imports' => 'stats, graphics, grDevices',
        'License' => 'GPL (>= 3)',
        'NeedsCompilation' => 'no'
      }
    end
    let(:archive_content) { IO.read(Rails.root.join('spec', 'assets', 'shape_1.4.3.tar.gz')) }
    before do
      stub_request(:get, 'http://cran.r-project.org/src/contrib/shape_1.4.3.tar.gz')
        .to_return(status: 200, body: archive_content, headers: {})
    end
    it do
      expect(fetcher.call).to eq(
        "Package: shape\n" \
        "Version: 1.4.3\n" \
        "Title: Functions for Plotting Graphical Shapes, Colors\n" \
        "Author: Karline Soetaert <karline.soetaert@nioz.nl>\n" \
        "Maintainer: Karline Soetaert <karline.soetaert@nioz.nl>\n" \
        "Depends: R (>= 2.01)\n" \
        "Imports: stats, graphics, grDevices\n" \
        "Description: Functions for plotting graphical shapes\n" \
        "  such as ellipses, circles, cylinders, arrows, ...\n" \
        "License: GPL (>= 3)\n" \
        "LazyData: yes\n" \
        "Repository: CRAN\n" \
        "Repository/R-Forge/Project: diagram\n" \
        "Repository/R-Forge/Revision: 80\n" \
        "Repository/R-Forge/DateTimeStamp: 2017-08-15 08:01:44\n" \
        "Date/Publication: 2017-08-16 08:59:39 UTC\n" \
        "NeedsCompilation: no\n" \
        "Packaged: 2017-08-15 08:05:13 UTC; rforge\n"
      )
    end
  end
end
