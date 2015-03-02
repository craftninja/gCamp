class Project < ActiveRecord::Base

  validates_presence_of :name
  has_many :tasks
  has_many :memberships

end
