class User < ActiveRecord::Base

  validates_presence_of :first_name, :last_name, :email
  validates_uniqueness_of :email
  has_secure_password

  def full_name
    "#{first_name} #{last_name}"
  end

end
