class Api::V1::RegistrationsController < ApplicationController
  def create
    @user = User.new email: params[:email], password: params[:password]
    return render json: { message: :created, token: @user.generate_token } if @user.save

    render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
  end
end
