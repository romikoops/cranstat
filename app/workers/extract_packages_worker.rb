class ExtractPackagesWorker
  include Sidekiq::Worker

  sidekiq_options retry: true, backtrace: true

  def perform
    text_data = PackageListFetcher.new.call
    index_data = PackageListParser.new(data: text_data, limit: 50).call
    index_data.each { |el| ExtractPackageDetailsWorker.perform_async(el) }
  end
end
