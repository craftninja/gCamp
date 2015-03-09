class Task < ActiveRecord::Base

  validates_presence_of :description
  has_many :comments, dependent: :destroy

end
