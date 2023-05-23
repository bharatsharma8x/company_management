class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :f_name
      t.string :l_name
      t.date :dob
      t.string :email
      t.text :address
      t.string :contact_no
      t.string :designation
      t.date :hire_date
      t.date :left_date
      t.integer :salary
      t.integer :ctc
      t.references :department, null: false, foreign_key: true

      t.timestamps
    end
  end
end 