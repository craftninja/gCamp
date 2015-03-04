class Project < ActiveRecord::Base

  validates_presence_of :name
  has_many :tasks
  has_many :users, through: :memberships
  has_many :memberships

end
