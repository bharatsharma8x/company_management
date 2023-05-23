class CreateAllocates < ActiveRecord::Migration[5.2]
  def change
    create_table :allocates do |t|
      t.references :employee, foreign_key: true
      t.references :department, foreign_key: true
      t.references :periferal, foreign_key: true
      t.date :allocate_from
      t.date :allocate_to

      t.timestamps
    end
  end
end

