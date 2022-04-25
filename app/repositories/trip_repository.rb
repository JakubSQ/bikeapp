class TripRepository
  class << self
    def week_result
      Trip.where('created_at BETWEEN ? AND ?', starting_date, today)
    end

    def month_result
      ordinalize_period
    end

    private

    def starting_date
      return today.at_beginning_of_week if caller[0][/`.*'/][1..-2].eql?('week_result')

      today.at_beginning_of_month
    end

    def ordinalize_period
      ordered_period.group_by{|x| x.created_at.strftime("#{x.created_at.day.ordinalize}, %B")}
    end

    def ordered_period
      month_period.order(created_at: :asc)
    end

    def month_period
      Trip.where('created_at BETWEEN ? AND ?', starting_date, today)
    end

    def today
      Time.zone.now
    end
  end
end