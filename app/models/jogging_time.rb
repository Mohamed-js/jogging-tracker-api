class JoggingTime < ApplicationRecord
  belongs_to :user
  validates :date, :distance, :time, presence: true
end
