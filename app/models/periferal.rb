class Periferal < ApplicationRecord
  belongs_to :department, optional: true
  belongs_to :employee, optional: true
  has_one_attached :bill
  validates :name, :description , presence: true
end
