class Membership < ActiveRecord::Base

  enum :role => [ :member, :owner ]
  belongs_to :user
  validates_presence_of :user
  validates_uniqueness_of :user, scope: :project_id, message: 'has already been added to this project'

end
