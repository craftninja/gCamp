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

  it 'Deletes memberships upon user destroy' do
    user = create_user
    project = create_project
    membership = create_membership(project, user)
    expect(Membership.all.size).to eq(1)
    user.destroy
    expect(Membership.all.size).to eq(0)
  end

  it 'Changes comment user id to nil upon user destroy' do
    user = create_user
    project = create_project
    task = create_task(project)
    comment = create_comment(task, user)
    user.destroy

    expect(Comment.find(comment.id).user_id).to eq(nil)
  end

end
