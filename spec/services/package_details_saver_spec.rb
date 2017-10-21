require 'rails_helper'

RSpec.describe PackageDetailsSaver do
  describe '#call' do
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
    let(:details_data) do
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
    let(:saver) { described_class.new(index_data: index_data, details_data: details_data) }

    context 'when package missing' do
      it do
        expect { saver.call }.to change { Package.count }.from(0).to(1)

        package = Package.first
        expect(package.name).to eq('shape')
        expect(package.version).to eq('1.4.3')
        expect(package.published_at).to eq(Time.zone.parse('2017-08-16 08:59:39 UTC'))
        expect(package.title).to eq('Functions for Plotting Graphical Shapes, Colors')
        expect(package.description).to eq(
          'Functions for plotting graphical shapes such as ellipses, circles, cylinders, arrows, ...'
        )

        expect(package.authors.count).to eq(1)
        author = package.authors.first
        expect(author.name).to eq('Karline Soetaert')
        expect(author.email).to eq('karline.soetaert@nioz.nl')

        expect(package.maintainers.count).to eq(1)
        maintainer = package.maintainers.first
        expect(maintainer.name).to eq('Karline Soetaert')
        expect(maintainer.email).to eq('karline.soetaert@nioz.nl')
      end
    end

    context 'when package present' do
      before do
        create(:package, name: 'shape')
      end

      it do
        expect { saver.call }.not_to change { Package.count }.from(1)

        package = Package.first
        expect(package.name).to eq('shape')
        expect(package.version).to eq('1.4.3')
        expect(package.published_at).to eq(Time.zone.parse('2017-08-16 08:59:39 UTC'))
        expect(package.title).to eq('Functions for Plotting Graphical Shapes, Colors')
        expect(package.description).to eq(
          'Functions for plotting graphical shapes such as ellipses, circles, cylinders, arrows, ...'
        )

        expect(package.authors.count).to eq(1)
        author = package.authors.first
        expect(author.name).to eq('Karline Soetaert')
        expect(author.email).to eq('karline.soetaert@nioz.nl')

        expect(package.maintainers.count).to eq(1)
        maintainer = package.maintainers.first
        expect(maintainer.name).to eq('Karline Soetaert')
        expect(maintainer.email).to eq('karline.soetaert@nioz.nl')
      end
    end
  end
end
