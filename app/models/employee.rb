class Employee < ApplicationRecord
  belongs_to :department
  has_many :periferals
  has_one_attached :resume
  has_one :bank_account, dependent: :destroy
  has_many :allocates
  has_many :attendance
  has_many :salaries

  accepts_nested_attributes_for :bank_account
  validates_associated :bank_account

  before_save :sanitize_data

  validates :f_name, :l_name, :dob, :email, :address, :contact_no, :hire_date,  presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  validate :dob_cannot_be_in_the_future
  validates :contact_no, uniqueness: true, numericality: { only_integer: true }, length: { minimum: 10 }
  validates :in_hand_salary, :ctc, numericality: { only_integer: true }

  after_create :update_department_employee_count
  after_update :update_department_employee_count
  after_destroy :update_department_employee_count

  private
  def update_department_employee_count
    department.update_employee_count
  end

  def sanitize_data
    self.f_name = f_name.squish
    self.l_name = l_name.squish
    self.email = email.squish
    self.address = address.squish
    self.designation = designation.squish
  end

  def dob_cannot_be_in_the_future
    errors.add(:dob, "cannot be in the future") if dob.present? && dob > Date.today
  end

  # check scopes
  #  scope :find_by_name(name), -> { where("name LIKE ?", "%#{name}%")}
end
