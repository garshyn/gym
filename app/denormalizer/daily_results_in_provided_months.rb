module Denormalizers
  class DailyResultsInProvidedMonths
    class << self
      def call(member, months)
        @member = member
        @months = months.map(&:beginning_of_month).sort

        daily_durations
      end

      private

      attr_reader :member, :months

      def daily_durations
        months.each_with_object(OpenStruct.new) do |beginning_of_month, struct|
          (beginning_of_month..beginning_of_month.end_of_month).each do |date|
            struct[:date] = date
            struct[:duration] = duration_for(date)
          end
        end
      end

      def duration_for(day)
        daily_results.select { |result| result.beginning_of_day.to_date == day[:date] }[:duration]
      end

      # AR object with beginning_of_day and duration
      # for day 1/1/2021 you worked out 5 seconds
      # for day 2/1/2021 you worked out 60 seconds
      def daily_results
        @daily_results ||= trainee.trainee_workouts.select('started_at as beginning_of_day, sum(<whatever>) as duration').
                           where('workout was done in the @months').group('beginning_of_day')
      end
    end
  end
end
