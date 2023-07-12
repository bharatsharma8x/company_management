class RemoveEmployeeCountFromDepartment < ActiveRecord::Migration[5.2]
  def change
    remove_column :departments, :employee_count
  end
end
  