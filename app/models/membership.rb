class Membership < ActiveRecord::Base

  enum :role => [ :member, :owner ]

end
