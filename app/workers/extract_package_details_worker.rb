class ExtractPackageDetailsWorker
  include Sidekiq::Worker

  sidekiq_options retry: true, backtrace: true

  def perform(index_data)
    text_data = PackageDetailsFetcher.new(data: index_data).call
    details_data = PackageDetailsParser.new(data: text_data).call
    PackageDetailsSaver.new(index_data: index_data, details_data: details_data).call
  end
end
