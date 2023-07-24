class Api::V1::ReportsController < ApplicationController
    def index
        weekly_report = current_user.jogging_times
                                   .group_by { |jogging_time| jogging_time.date.beginning_of_week }
                                   .transform_values { |jogging_times| calculate_average_speed_and_distance(jogging_times) }

        render json: weekly_report
    end

    private
    def calculate_average_speed_and_distance(jogging_times)
        total_distance = jogging_times.sum(&:distance)
        total_time = jogging_times.sum(&:time)
        average_speed = total_distance / (total_time / 60.0) # Speed in units per minute (e.g., km/min)

        { average_speed: average_speed, total_distance: total_distance }
    end
end
