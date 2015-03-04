class Membership < ActiveRecord::Base

  enum :role => [ :member, :owner ]
  belongs_to :user
  validates_presence_of :user

end
