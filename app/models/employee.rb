class Employee < ApplicationRecord
  include StripSpacesConcern

  belongs_to :user
  belongs_to :department
  has_many :periferals
  has_one_attached :resume
  has_one :bank_account, dependent: :destroy
  has_many :allocates
  has_many :attendance
  has_many :salaries

  accepts_nested_attributes_for :bank_account
  validates_associated :bank_account

  validates :f_name, :l_name, :dob, :email, :address, :contact_no, :hire_date, :department_id, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  validate :dob_cannot_be_in_the_future
  validates :contact_no, uniqueness: true, numericality: { only_integer: true }, length: { minimum: 10 }
  validates :in_hand_salary, :ctc, numericality: { only_integer: true }

  scope :search_by_name, ->(query) { where("f_name ILIKE :query OR email ILIKE :query", query: "%#{query}%") }

  private

  def dob_cannot_be_in_the_future
    errors.add(:dob, 'cannot be in the future') if dob.present? && dob > Date.today
  end

end
