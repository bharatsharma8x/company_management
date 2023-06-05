class CreateHolidays < ActiveRecord::Migration[5.2]
  def change
    create_table :holidays do |t|
      t.date :holiday
      t.string :title

      t.timestamps
    end
  end
end
