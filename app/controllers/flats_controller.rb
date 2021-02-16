class FlatsController < ApplicationController
  def index
    @flats = Flat.where.not(latitude: nil, longitude: nil)
    @markers = @flats.map do |flat|
      {
        name: flat.name,
        lat: flat.latitude,
        lng: flat.longitude,
      }
    end

    respond_to do |format|
      format.html
      format.json { render json: @markers }
    end
  end
end
