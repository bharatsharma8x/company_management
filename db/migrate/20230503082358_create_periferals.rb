class CreatePeriferals < ActiveRecord::Migration[5.2]
  def change
    create_table :periferals do |t|
      t.string :name
      t.text :description
      t.string :category
      t.date :purchase_date
      t.integer :purchase_cost
      t.string :condition
      t.date :warranty_start_date
      t.integer :warranty_duration_months
      t.date :warranty_end_date
      t.references :department, foreign_key: true
      t.references :employee, foreign_key: true

      t.timestamps
    end
  end
end
