class CreateBankAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :bank_accounts do |t|
      t.string :bank_name
      t.string :ifsc_code
      t.string :account_number
      t.references :employee, foreign_key: true

      t.timestamps
    end
  end
end
