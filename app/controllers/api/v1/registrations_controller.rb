class Api::V1::RegistrationsController < ApplicationController
    def create
        user = User.find_by email: params[:email]
        
        return render json: { error: 'user already exists' }, status: :unprocessable_entity if user

        user = User.new registration_params
        return render json: { message: :created, token: user.generate_token } if user.save

        render json: { error: user.errors.full_messages }, status: :unprocessable_entity
    end

    private
    def registration_params
        params.permit(:email, :password, :password_confirmation)
    end
end
