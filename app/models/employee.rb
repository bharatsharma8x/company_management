class Employee < ApplicationRecord
  belongs_to :department
  has_many :periferals
  has_one_attached :resume
  # validates :f_name, :l_name, :dob, :email, :address, :contact_no, :designation, :hire_date,  presence: true

  after_create :update_department_employee_count
  after_update :update_department_employee_count
  after_destroy :update_department_employee_count

  private
  def update_department_employee_count
    department.update_employee_count
  end
  # check scopes
  #  scope :find_by_name(name), -> { where("name LIKE ?", "%#{name}%")}
end