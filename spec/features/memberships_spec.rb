require 'rails_helper'

feature 'Memberships -' do
  scenario 'The project show has membership count link to projects memberships index' do
    user = create_user
    project = create_project
    create_membership(project, user)

    login(user)
    visit project_path(project)
    click_on '1 Member'
    within '.page-header' do
      expect(page).to have_content("#{project.name}: Manage Members")
    end
    within '.breadcrumb' do
      expect(page).to have_content("Projects #{project.name} Memberships")
    end
    other_user = create_user
    membership = create_membership(project, other_user)
    visit project_path(project)
    expect(page).to have_content('2 Memberships')
  end

  scenario 'Members cannot manage memberships, but can delete self membership' do
    member = create_user
    project = create_project
    another_member = create_user
    create_membership(project, member, :role => :member)
    create_membership(project, another_member, :role => :member)
    login(member)

    visit project_memberships_path(project)
    expect(page).to_not have_content('Please select a user...')
    expect(page).to_not have_button('Update')
    expect(all('tr')[0]).to have_content(member.full_name)
    expect(all('tr')[0]).to have_css('.glyphicon-remove')
    all('.glyphicon-remove')[0].click
    expect(page).to have_content("#{member.full_name} was successfully removed")
    expect(current_path).to eq(projects_path)
    expect(Membership.find_by(:user_id => member.id)).to eq(nil)
  end

  scenario 'Owner can add a member to a project, update role, delete membership' do
    owner = create_user
    project = create_project
    create_membership(project, owner, :role => :owner)
    user = create_user

    login(owner)
    visit project_memberships_path(project)
    within '.well' do
      select user.full_name, from: :membership_user_id
      select 'Member', from: :membership_role
    end
    click_on 'Add New Member'
    expect(page).to have_content("#{user.full_name} was successfully added")
    within 'table' do
      expect(page).to have_link(user.full_name)
    end
    within '.table' do
      all('#membership_role')[1].select 'Owner'
      all('.btn')[1].click
    end
    expect(page).to have_content("#{user.full_name} was successfully updated")
    all('.glyphicon')[1].click
    expect(page).to have_content("#{user.full_name} was successfully removed")
  end

  scenario 'Owner must select a user for a membership' do
    owner = create_user
    project = create_project
    create_membership(project, owner, :role => :owner)
    login(owner)
    visit project_memberships_path(project)
    click_on 'Add New Member'
    expect(page).to have_content("1 error prohibited this form from being saved: User can't be blank")
  end

  scenario 'Owner cannot add the same user twice as member of project' do
    owner = create_user
    project = create_project
    create_membership(project, owner, :role => :owner)
    login(owner)
    user = create_user
    visit project_memberships_path(project)
    within '.well' do
      select user.full_name, from: :membership_user_id
      select 'Member', from: :membership_role
    end
    click_on 'Add New Member'
    within '.well' do
      select user.full_name, from: :membership_user_id
      select 'Member', from: :membership_role
    end
    click_on 'Add New Member'
    expect(page).to have_content('User has already been added to this project')
  end

end
