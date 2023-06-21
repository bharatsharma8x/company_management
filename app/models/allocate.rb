class Allocate < ApplicationRecord
  belongs_to :employee, optional: true
  belongs_to :department, optional: true
  belongs_to :periferal, optional: true

  validates :department_id, presence: { message: 'Department Name cannot be blank.' }
  validates :employee_id, presence: { message: 'Employee Name cannot be blank.' }
  validates :periferal_id, presence: { message: 'Periferal Name cannot be blank.' }
end