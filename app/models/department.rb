class Department < ApplicationRecord
  has_many :employees
  has_many :periferals
  validates :dep_name, presence: true

  # scope :find_by_name, -> (name) { where("dep_name ILIKE ? ", name)}
  # def self.find_by_name(name)
  #   where("dep_name ILIKE ? ", name)
  # end
  
end
