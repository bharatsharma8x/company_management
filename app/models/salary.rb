class Salary < ApplicationRecord
  include StripSpacesConcern

  attr_accessor :hra, :allowance, :total_earning, :income_tax, :prof_tax, :total_deduction

  belongs_to :employee
end
