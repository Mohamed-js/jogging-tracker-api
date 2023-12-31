# frozen_string_literal: true

class ApplicationController < ActionController::API
  def current_user
    authoriztion_header = request.headers['Authorization']
    return render json: :authentication_error unless authoriztion_header

    token = authoriztion_header[7..authoriztion_header.length]
    user_id = AuthService.decode_token(token)
    user = User.find user_id

    return render json: { message: 'You are not authorized.' }, status: :unauthorized unless user
    return render json: { message: 'You need to login first.' }, status: :unauthorized unless user.logged_in

    user
  end

  rescue_from CanCan::AccessDenied do |_exception|
    render nothing: true, status: :unauthorized
  end
  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render nothing: true, status: :not_found
  end
end
