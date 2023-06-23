class User < ApplicationRecord
  has_one :employee

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # defining rolls
  enum role: %i[admin employee]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
