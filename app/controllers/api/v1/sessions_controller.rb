# frozen_string_literal: true

module Api
  module V1
    class SessionsController < ApplicationController
      before_action :set_user, only: :destroy
      def create
        user = User.find_by(email: params[:email])
        if user&.authenticate(params[:password])
          user.mark_logged_in
          token = user.generate_token
          render json: { token: token }
        else
          render json: { errors: ['Invalid Email or Password'] }, status: :unauthorized
        end
      end

      def destroy
        @current_user.mark_logged_out
        render json: { message: 'logged out' }
      end

      private

      def set_user
        @current_user = User.find(params[:id])
      end
    end
  end
end
