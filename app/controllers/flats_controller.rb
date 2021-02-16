class FlatsController < ApplicationController
  def index
    @flats = Flat.where.not(latitude: nil, longitude: nil)
    @markers = @flats.map do |flat|
      {

        lat: flat.latitude,
        lng: flat.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { flat: flat }),
      }
    end

    respond_to do |format|
      format.html
      format.json { render json: @markers }
    end
  end
end
