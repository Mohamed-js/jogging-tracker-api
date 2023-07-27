# frozen_string_literal: true

class JoggingTime < ApplicationRecord
  # Distances are in km, while times are in minutes
  belongs_to :user
  validates :date, :distance, :time, presence: true
  validates_numericality_of :distance, :time, message: 'is not a number'
end
