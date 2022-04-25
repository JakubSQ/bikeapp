module Api
  class TripsController < ApplicationController
    protect_from_forgery with: :null_session
    
    def index
      trips = Trip.all
      render json: trips
    end

    def create
      new_trip = Trips::Creator.new.call(trip_params)
      render json: new_trip.payload unless new_trip.success?
    end

    def show
      trip = Trip.find(params[:id])
      render json: trip
    end
    
    def weekly
      trips = TripRepository.week_result
      week_stat = Stats::Period.new.call(trips, request.path)
      render json: week_stat
    end

    def monthly
      trips = TripRepository.month_result
      month_stat = Stats::Period.new.call(trips, request.path)
      render json: month_stat
    end

    private

    def trip_params
      params.require(:trip).permit(:start_address, :destination_address, :price)
    end
  end
end