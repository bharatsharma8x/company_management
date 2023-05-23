class Allocate < ApplicationRecord
  belongs_to :employee, optional: true
  belongs_to :department, optional: true
  belongs_to :periferal, optional: true
  before_save :set_today_date

  def set_today_date
    self.allocate_from = Date.current
  end
end
