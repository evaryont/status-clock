class Clock < ActiveRecord::Base
  has_many :user
  has_many :status
end
