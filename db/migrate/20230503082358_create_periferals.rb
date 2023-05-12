class CreatePeriferals < ActiveRecord::Migration[5.2]
  def change
    create_table :periferals do |t|
      t.string :name
      t.text :description
      t.integer :supplier_id
      t.integer :manufacture_id
      t.date :delivery_date
      t.date :order_date
      t.date :warranty_start_date
      t.integer :warranty_duration
      t.references :department, foreign_key: true
      t.references :employee, foreign_key: true

      t.timestamps
    end
  end
end
