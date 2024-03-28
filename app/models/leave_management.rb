class LeaveManagement < ApplicationRecord
  belongs_to :employee

  enum status: { pending: 'Pending', approved: 'Approved', rejected: 'Rejected' }
  enum leave_type: {
       earned_leave: 'Earned Leave',
       maternity_leave: 'Maternity Leave',
     }

  validates :start_date, :end_date, :leave_type, :status, presence: true
  validate :end_date_after_start_date

  after_initialize :set_default_status, if: :new_record?

  private

  def end_date_after_start_date
    errors.add(:end_date, 'must be after start date') if end_date <= start_date
  end

  def set_default_status
    self.status ||= :pending
  end
end
