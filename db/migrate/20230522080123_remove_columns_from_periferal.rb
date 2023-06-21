class RemoveColumnsFromPeriferal < ActiveRecord::Migration[5.2]
  def change
    remove_column :periferals, :department_id
    remove_column :periferals, :employee_id
  end
end
