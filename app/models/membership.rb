class Membership < ActiveRecord::Base

  enum :role => [ :member, :owner ]
  belongs_to :user

end
