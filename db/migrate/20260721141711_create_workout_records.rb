class CreateWorkoutRecords < ActiveRecord::Migration[8.1]
  def change
    create_table :workout_records do |t|
      t.references :workout, null: false, foreign_key: true
      t.references :menu, null: false, foreign_key: true
      t.decimal :weight
      t.integer :reps
      t.integer :sets

      t.timestamps
    end
  end
end
