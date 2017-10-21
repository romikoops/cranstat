class PackagesController < ApplicationController
  def index
    @packages = Package.includes(:authors, :maintainers).order(:name)

    if @packages.count.positive?
      render :index
    else
      render plain: 'No data found'
    end
  end
end
