class PackagesController < ApplicationController
  def index
    @packages = Package.includes(:contributors).all
    render json: @packages, :include => [:authors, :maintainers], status: status
  end
end
