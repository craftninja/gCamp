class User < ActiveRecord::Base

  validates_presence_of :first_name, :last_name, :email
  validates_uniqueness_of :email
  before_destroy :destroy_assoc_memberships
  before_destroy :comments_user_id_nil
  has_many :projects, through: :memberships
  has_many :memberships
  has_secure_password


  def destroy_assoc_memberships
    Membership.where(:user_id => self.id).destroy_all
  end

  def comments_user_id_nil
    Comment.where(:user_id => self.id).each do |comment|
      comment.update(:user_id => nil)
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end

end
