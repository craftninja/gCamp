class Project < ActiveRecord::Base

  validates_presence_of :name
  has_many :tasks, dependent: :destroy
  has_many :users, through: :memberships
  has_many :memberships, dependent: :destroy

end
