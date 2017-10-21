require 'rubygems/package'

class PackageDetailsFetcher
  URL_HOST = 'http://cran.r-project.org'.freeze

  attr_reader :data

  def initialize(data: nil)
    @data = data
  end

  def call
    content = make_http_request.body
    res = Gem::Package::TarReader.new(
      Zlib::GzipReader.new(StringIO.new(content))
    )
    res.rewind
    description_content(res)
  end

  private

  def connection
    Faraday.new(url: URL_HOST)
  end

  def make_http_request
    connection.get do |req|
      req.url(url_path)
      req.options.timeout = 120
      req.options.open_timeout = 20
    end
  end

  def url_path
    "/src/contrib/#{pkg_name}_#{pkg_version}.tar.gz"
  end

  def pkg_name
    data['Package']
  end

  def pkg_version
    data['Version']
  end

  def description_content(tar_data)
    tar_data.find { |el| el.file? && el.full_name.match?(/DESCRIPTION\z/i) }&.read
  end
end
