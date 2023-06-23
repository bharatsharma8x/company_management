class Salary < ApplicationRecord
  include StripSpacesConcern

  belongs_to :employee
end
