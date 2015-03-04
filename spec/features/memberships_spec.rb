require 'rails_helper'

feature 'Memberships -' do
  scenario 'The project show has membership count link to projects memberships index' do
    user = create_user
    project = create_project
    login(user)
    visit project_path(project)
    click_on '0 Members'
    within '.page-header' do
      expect(page).to have_content("#{project.name}: Manage Members")
    end
    within '.breadcrumb' do
      expect(page).to have_content("Projects #{project.name} Memberships")
    end
    membership = create_membership(project, user)
    visit project_path(project)
    expect(page).to have_content('1 Member')
  end

  scenario 'User can add a member to a project' do
    user = create_user
    project = create_project
    login(user)
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
  end

end
