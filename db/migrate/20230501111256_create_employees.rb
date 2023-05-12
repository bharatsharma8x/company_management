class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :f_name
      t.string :l_name
      t.date :dob
      t.string :email
      t.text :address
      t.bigint :contact_no
      t.string :designation
      t.date :hire_date
      t.integer :salary
      t.integer :ctc
      t.bigint :bank_account_number
      t.references :department, null: false, foreign_key: true

      t.timestamps
    end
  end
end