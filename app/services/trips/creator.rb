# frozen_string_literal: true

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

      assign_distance(params)
      @trip.save
    end

    def assign_distance(params)
      @trip.distance = distance(params)
    end

    def distance(params)
      (api_response(params)['rows'][0]['elements'][0]['distance']['value'] / 1000.to_f).ceil
    end

    def api_response(params)
      HTTParty.get(URI("https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{trip_parameters(params)[:origin]}&destinations=#{trip_parameters(params)[:destination]}&key=#{ENV.fetch(
        'DISTANCE_KEY', nil
      )}&language=pl&region=PL"))
    end

    def trip_parameters(params)
      { origin: params[:start_address].gsub(/[., '"]/, ''),
        destination: params[:destination_address].gsub(/[., '"]/, '') }
    end
  end
end
