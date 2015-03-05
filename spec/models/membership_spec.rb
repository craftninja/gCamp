require 'spec_helper'

describe Membership do
  it 'validates presence of User on Membership' do
    user = create_user
    membership = Membership.new
    expect(membership.valid?).to be(false)
    membership.user = user
    expect(membership.valid?).to be(true)
  end

  it 'validates scope of only one user per project' do
    project = create_project
    user = create_user
    other_user = create_user
    Membership.create!(
      :user => user,
      :project_id => project.id,
    )
    membership = Membership.new
    membership.project_id = project.id
    membership.user = user
    expect(membership.valid?).to be(false)
    membership.user = other_user
    expect(membership.valid?).to be(true)
  end
end
