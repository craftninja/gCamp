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
end
