require 'spec_helper'

describe 'User -' do
  it 'Validates presence of First Name, Last Name, Email' do
    user = User.new
    expect(user.valid?).to be(false)
    user.first_name = 'Luke'
    expect(user.valid?).to be(false)
    user.last_name = 'Bartel'
    expect(user.valid?).to be(false)
    user.email = 'luke@example.com'
    expect(user.valid?).to be(false)
    user.password = 'password'
    expect(user.valid?).to be(true)
  end

  it 'Validates uniqueness of Email' do
    user1 = User.create!(
      :first_name => 'Luke',
      :last_name  => 'Bartel',
      :email      => 'luke@example.com',
      :password   => 'password'
    )

    user2 = User.new(
      :first_name => 'Luke',
      :last_name  => 'McComb',
      :email      => 'luke@example.com',
      :password   => 'password'
    )

    expect(user2.valid?).to be(false)
  end
end
