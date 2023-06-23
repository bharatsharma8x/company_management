class Periferal < ApplicationRecord
  include StripSpacesConcern

  has_many :allocates
  has_one_attached :bill

  validates :name, :purchase_date, :purchase_cost, presence: true

  before_save :calculate_warranty_end_date

  private

  def calculate_warranty_end_date
    if warranty_duration_months.present?
      self.warranty_end_date = warranty_start_date + warranty_duration_months.to_i.months
    end
  end

end