class PackageListFetcher
  URL_HOST = 'http://cran.r-project.org'.freeze
  URL_PATH = '/src/contrib/PACKAGES'.freeze

  def call
    make_http_request.body
  end

  private

  def connection
    Faraday.new(url: URL_HOST)
  end

  def make_http_request
    connection.get do |req|
      req.url URL_PATH
      req.options.timeout = 120
      req.options.open_timeout = 20
    end
  end
end
