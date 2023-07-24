class User < ApplicationRecord
    has_secure_password
    has_many :jogging_times

    enum role: { regular_user: 0, user_manager: 1, admin: 2 }
    validates :email, :digest_password, presence: true

end
