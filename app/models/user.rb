class User < ApplicationRecord
    has_secure_password
    has_many :jogging_times

    enum role: { regular_user: 0, user_manager: 1, admin: 2 }
    validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
    validates :password, presence: true, length: { minimum: 6 }

    def generate_token
        payload = { user_id: id }
        AuthService.encode_token(payload)
    end
end
