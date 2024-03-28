class CreateLeaveManagements < ActiveRecord::Migration[5.2]
  def change
    create_table :leave_managements do |t|
      t.references :employee, foreign_key: true
      t.string :leave_type
      t.date :start_date
      t.date :end_date
      t.string :status

      t.timestamps
    end
  end
end
