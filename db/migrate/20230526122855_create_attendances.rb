class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |t|
      t.references :employee, foreign_key: true
      t.string :status
      t.datetime :check_in_time
      t.datetime :check_out_time
      t.decimal :hours_worked

      t.timestamps
    end
  end
end
