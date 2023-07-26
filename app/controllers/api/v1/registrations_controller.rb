# frozen_string_literal: true

module Api
  module V1
    class RegistrationsController < ApplicationController
      def create
        @user = User.new email: params[:email], password: params[:password]
        return render json: { message: :created, token: @user.generate_token } if @user.save

        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end
end
