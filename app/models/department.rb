class Department < ApplicationRecord
  has_many :employees
  has_many :periferals
  validates :department_name, presence: true, uniqueness: true
  before_save :sanitize_data


  def update_employee_count
    self.employee_count = employees.count
    save
  end

  private
  def sanitize_data
    self.department_name = department_name.squish
  end
  # scope :find_by_name, -> (name) { where("dep_name ILIKE ? ", name)}
  # def self.find_by_name(name)
  #   where("dep_name ILIKE ? ", name)
  # end
end
