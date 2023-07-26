class User < ApplicationRecord
  has_secure_password
  has_many :jogging_times

  enum role: { regular_user: 0, user_manager: 1, admin: 2 }
  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 6 }, on: :create

  def generate_token
    payload = { user_id: id }
    AuthService.encode_token(payload)
  end

  def mark_logged_in
    update_attribute(:logged_in, true)
  end

  def mark_logged_out
    update_attribute(:logged_in, false)
  end
end
