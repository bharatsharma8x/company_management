class CreateDepartments < ActiveRecord::Migration[5.2]
  def change
    create_table :departments do |t|
      t.string :department_name
      t.integer :employee_count
      t.timestamps
    end
  end
end
