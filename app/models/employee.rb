class Employee < ApplicationRecord
  belongs_to :department
  has_many :periferals
  has_one_attached :resume
  # validates :f_name, :l_name, :dob, :email, :address, :contact_no, :designation, :hire_date,  presence: true

  # check scopes
  #  scope :find_by_name(name), -> { where("name LIKE ?", "%#{name}%")}
end