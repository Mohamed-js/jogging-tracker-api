class Api::V1::JoggingTimesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_jogging_time, only: [:show, :update, :destroy]
  load_and_authorize_resource

  # GET /jogging_times
  def index
    if params[:from_date] && params[:to_date]
      @jogging_times = current_user.jogging_times.where(date: params[:from_date]..params[:to_date])
    else
      @jogging_times = current_user.jogging_times
    end

    render json: @jogging_times
  end

  # GET /jogging_times/1
  def show
    render json: @jogging_time
  end

  # POST /jogging_times
  def create
    @jogging_time = current_user.jogging_times.build(jogging_time_params)

    if @jogging_time.save
      render json: @jogging_time, status: :created
    else
      render json: @jogging_time.errors.full_messages, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /jogging_times/1
  def update
    if @jogging_time.update(jogging_time_params)
      render json: @jogging_time
    else
      render json: @jogging_time.errors.full_messages, status: :unprocessable_entity
    end
  end

  # DELETE /jogging_times/1
  def destroy
    @jogging_time.destroy

    render json: :deleted
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_jogging_time
      @jogging_time = current_user.jogging_times.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def jogging_time_params
      params.require(:jogging_time).permit(:date, :distance, :time)
    end
end
