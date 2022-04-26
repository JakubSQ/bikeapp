# frozen_string_literal: true

module Stats
  class Period
    def call(trips, request_path)
      return week_result(trips) if week_path?(request_path)

      month_result(trips)
    end

    private

    def week_result(trips)
      { total_distance: total_distance(trips),
        total_price: total_price(trips) }
    end

    def total_distance(trips)
      trip_serializer(trips).map { |trip| trip.object.distance }.sum.to_s.concat('km')
    end

    def total_price(trips)
      trip_serializer(trips).map { |trip| trip.object.price }.sum.round(2).to_s.concat('PLN')
    end

    def trip_serializer(trips)
      ActiveModel::Serializer::CollectionSerializer.new(trips, serializer: TripSerializer)
    end

    def week_path?(request_path)
      request_path.eql?('/api/stats/weekly')
    end

    def month_result(trips)
      trips.map do |k, v|
        { day: k,
          total_distance: v.sum(&:distance).to_s.concat('km'),
          avg_ride: (v.sum(&:distance) / v.count).to_s.concat('km'),
          avg_price: (v.sum(&:price) / v.count).round(2).to_s.concat('PLN') }
      end
    end
  end
end
