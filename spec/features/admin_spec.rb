require 'rails_helper'

feature 'Admins -' do

  scenario 'Users cannot make self or other users admins' do
    user = create_user
    login(user)
    visit user_path(user)
    expect(page).to_not have_content('Admin')
    visit new_user_path
    expect(page).to_not have_content('Admin')
  end

  scenario 'Admins can create admins' do
    user = create_user(:admin => true)
    login(user)
    visit new_user_path
    fill_in 'First Name', with: 'Emily'
    fill_in 'Last Name', with: 'Platzer'
    fill_in 'Email', with: 'emily@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'
    check 'Admin'
    click_on 'Create User'
    expect(page).to have_content('Emily Platzer')
  end

  scenario 'Admins can manage all projects, tasks, memberships, users' do
    user = create_user
    project = create_project
    task = create_task(project)
    membership = create_membership(project, user)

    admin = create_user(:admin => true)
    login(admin)

    visit users_path
    expect(page).to have_content('Edit', count: 2)
    visit user_path(user)
    expect(page).to have_content('Edit')
    expect(page).to have_content(user.email)
    visit edit_user_path(user)
    expect(page).to have_content('Delete User')

    visit projects_path
    click_on project.name
    expect(page).to have_content('1 Membership')
    click_on '1 Membership'
    within '.table' do
      select 'Owner', from: :membership_role
      click_on 'Update'
    end
    expect(page).to have_content("#{user.full_name} was successfully updated")
    within '.well' do
      select admin.full_name, from: :membership_user_id
      select 'Member', from: :membership_role
    end
    click_on 'Add New Member'
    expect(page).to have_content("#{admin.full_name} was successfully added")
    first('.glyphicon-remove').click
    expect(page).to have_content("#{admin.full_name} was successfully removed")

    visit project_tasks_path(project)
    expect(page).to have_content(task.description)
    expect(page).to have_content('Edit')
    find('.glyphicon-remove').click
    expect(page).to_not have_content(task.description)

    visit project_path(project)
    click_on 'Delete'
    expect(page).to have_content('Project was successfully deleted')
  end

end
