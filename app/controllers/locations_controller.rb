class LocationsController < ApplicationController
  def search
    locations = Location.search(params[:description], params[:term])
    render json: locations
  end
end
