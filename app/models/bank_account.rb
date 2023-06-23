class BankAccount < ApplicationRecord
  include StripSpacesConcern

  belongs_to :employee

  validates :bank_name, presence: true
  validates :ifsc_code, presence: true
  validates :account_number, presence: true, numericality: { only_integer: true }
end
