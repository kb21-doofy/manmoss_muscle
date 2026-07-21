class WorkoutRecord < ApplicationRecord
  belongs_to :workout
  belongs_to :menu
end
