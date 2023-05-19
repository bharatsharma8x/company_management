class BankAccount < ApplicationRecord
  belongs_to :employee

  validates :bank_name, presence: true ,numericality: { only_integer: false }
  validates :ifsc_code, presence: true
  validates :account_number, presence: true ,numericality: { only_integer: true }
end
