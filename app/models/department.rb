class Department < ApplicationRecord
  include StripSpacesConcern

  has_many :allocates
  has_many :employees, dependent: :restrict_with_exception
  has_many :periferals

  validates :department_name, presence: true, uniqueness: true

  def update_employee_count
    self.employee_count = employees.count
    save
  end
end
