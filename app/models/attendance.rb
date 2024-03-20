class Attendance < ApplicationRecord
  include StripSpacesConcern

  belongs_to :employee

  validates :status, presence: true
  validates :employee_id, presence: true

  before_save :calculate_hours_worked

  def calculate_hours_worked
    return unless check_in_time && check_out_time

    self.hours_worked = (check_out_time - check_in_time) / 3600.0
    self.hours_worked = hours_worked.round(2)

    save if persisted?
    hours_worked
  end

end
