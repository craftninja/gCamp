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
    expect(user.valid?).to be(true)
  end
end
