require 'spec_helper'

describe Membership do
  it 'validates presence of User on Membership' do
    user = create_user
    membership = Membership.new
    expect(membership.valid?).to be(false)
    membership.user = user
    expect(membership.valid?).to be(true)
  end
end
