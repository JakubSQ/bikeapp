module Trips
  class Creator
    def call(params)
      if new_trip(params)
        OpenStruct.new({ success?: true, payload: @trip })
      else
        OpenStruct.new({ success?: false, payload: @trip.errors.full_messages })
      end
    end

    private

    def new_trip(params)
      @trip = Trip.new(params)
      return nil unless @trip.valid?

      origin = params[:start_address].gsub(/[., '"]/,'')
      destination = params[:destination_address].gsub(/[., '"]/,'')
      
      binding.pry
      
      response = HTTParty.get(url = URI("https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{origin}&destinations=#{destination}&key=#{Rails.application.credentials.google_distance[:secret_access_key]}&language=pl&region=PL"))
      @trip.distance = (response["rows"][0]["elements"][0]["distance"]["value"]/1000.to_f).ceil
      @trip.save
    end
  end
end
