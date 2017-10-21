require 'rails_helper'

RSpec.describe PackageListFetcher do
  let(:fetcher) { described_class.new }

  describe '#call' do
    let(:body) do
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
    before do
      stub_request(:get, 'http://cran.r-project.org/src/contrib/PACKAGES')
        .to_return(status: 200, body: body, headers: {})
    end
    it { expect(fetcher.call).to eq(body) }
  end
end
