class CreateSalaries < ActiveRecord::Migration[5.2]
  def change
    create_table :salaries do |t|
      t.integer :employee_id
      t.date :month
      t.integer :total_days
      t.integer :present_days
      t.integer :leaves
      t.integer :absents
      t.decimal :salary

      t.timestamps
    end
  end
end
