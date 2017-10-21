require 'rails_helper'

RSpec.describe PackageDetailsParser do
  describe '#call' do
    context 'when data present' do
      let(:data) do
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
      end

      let(:package_description) do
        {
          'Package' => 'shape',
          'Version' => '1.4.3',
          'Title' => 'Functions for Plotting Graphical Shapes, Colors',
          'Author' => 'Karline Soetaert <karline.soetaert@nioz.nl>',
          'Maintainer' => 'Karline Soetaert <karline.soetaert@nioz.nl>',
          'Depends' => 'R (>= 2.01)',
          'Imports' => 'stats, graphics, grDevices',
          'Description' => 'Functions for plotting graphical shapes such as ellipses, circles, cylinders, arrows, ...',
          'License' => 'GPL (>= 3)',
          'LazyData' => 'yes',
          'Repository' => 'CRAN',
          'Repository/R-Forge/Project' => 'diagram',
          'Repository/R-Forge/Revision' => '80',
          'Repository/R-Forge/DateTimeStamp' => '2017-08-15 08:01:44',
          'Date/Publication' => '2017-08-16 08:59:39 UTC',
          'NeedsCompilation' => 'no',
          'Packaged' => '2017-08-15 08:05:13 UTC; rforge'
        }
      end

      let(:parser) { described_class.new(data: data) }

      it { expect(parser.call).to eq(package_description) }
    end

    context 'when data blank' do
      let(:parser) { described_class.new }
      it { expect(parser.call).to eq({}) }
    end
  end
end
