class Workout < ApplicationRecord
  belongs_to :user
  has_many :workout_records, dependent: :destroy
end
