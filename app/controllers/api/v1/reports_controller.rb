# frozen_string_literal: true

module Api
  module V1
    class ReportsController < ApplicationController
      def index
        weekly_report = current_user.jogging_times
                                    .group_by { |jogging_time| jogging_time.date.beginning_of_week }
                                    .transform_values { |week_jogging_times| calculate_average_speed_and_distance(week_jogging_times) }

        render json: weekly_report
      end

      private

      def calculate_average_speed_and_distance(jogging_times)
        total_distance = jogging_times.sum(&:distance) # In km
        total_time = jogging_times.sum(&:time) # In minutes
        average_speed = total_distance / (total_time / 60.0) # Speed (km/hr) - If we need it in minutes, we delete the /60

        { average_speed: average_speed, total_distance: total_distance, speed_unit: 'km/hr' }
      end
    end
  end
end
