class Api::V1::SessionsController < ApplicationController
    def create
        user = User.find_by(email: params[:email])
        if user&.authenticate(params[:password])
          token = user.generate_token
          render json: { token: token }
        else
          render json: { errors: ['Invalid Email or Password'] }, status: :unauthorized
        end
    end
end