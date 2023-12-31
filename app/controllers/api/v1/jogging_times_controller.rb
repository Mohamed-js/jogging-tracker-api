# frozen_string_literal: true

module Api
  module V1
    class JoggingTimesController < ApplicationController
      load_and_authorize_resource
      before_action :set_jogging_times, only: [:index]
      before_action :set_jogging_time, only: %i[show update destroy]

      def index
        if params[:from_date] && params[:to_date]
          @jogging_times = @jogging_times.where(date: params[:from_date]..params[:to_date])
        end
        render json: @jogging_times
      end

      def show
        render json: @jogging_time
      end

      def create
        @jogging_time = current_user.jogging_times.build(jogging_time_params)

        if @jogging_time.save
          render json: @jogging_time, status: :created
        else
          render json: { errors: @jogging_time.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /jogging_times/1
      def update
        if @jogging_time.update(jogging_time_params)
          render json: @jogging_time
        else
          render json: { errors: @jogging_time.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /jogging_times/1
      def destroy
        @jogging_time.destroy

        head :no_content
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_jogging_time
        @jogging_time = JoggingTime.find(params[:id])
      end

      def set_jogging_times
        @jogging_times = JoggingTime.all if current_user.admin?
        @jogging_times = current_user.jogging_times if current_user.regular_user?
      end

      # Only allow a list of trusted parameters through.
      def jogging_time_params
        params.require(:jogging_time).permit(:date, :distance, :time)
      end
    end
  end
end
