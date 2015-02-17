require 'rails_helper'

feature 'Users -' do

  scenario 'Users can create users, see user show' do
    fname = 'Luke'
    lname = 'Bartel'
    email = 'luke@example.com'

    visit '/'
    click_on 'Users'
    click_on 'New User'
    fill_in 'First Name', with: fname
    fill_in 'Last Name', with: lname
    fill_in 'Email', with: email
    expect(page).to have_link('Cancel')
    click_on 'Create User'
    within '.page-header' do
      expect(page).to have_content('Users')
    end

    expect(page).to have_link(email)
    click_on "#{fname} #{lname}"
    within '.page-header' do
      expect(page).to have_content("#{fname} #{lname}")
    end
    expect(page).to have_link(email)
    expect(page).to have_link('Edit')
  end

  scenario 'Users can update and delete users' do
    fname = 'Luke'
    lname = 'Bartel'

    visit '/users'
    click_on 'New User'
    fill_in 'First Name', with: fname
    fill_in 'Last Name', with: lname
    fill_in 'Email', with: "#{fname}@example.com"
    click_on 'Create User'
    click_on 'Edit'
    fill_in 'Email', with: "#{lname}@example.com"
    click_on 'Update User'
    expect(page).to have_content("#{lname}@example.com")
    expect(page).to_not have_content("#{fname}@example.com")
    click_on 'Edit'
    within '.well' do
      click_on 'Delete User'
    end
    expect(page).to have_content('User was successfully deleted')
  end

  scenario 'User must enter first name, last name and email' do
    visit users_path
    click_on 'New User'
    click_on 'Create User'
    within '.alert.alert-danger' do
      expect(page).to have_content('3 errors prohibited this form from being saved')
      within 'ul' do
        expect(page).to have_content("First name can't be blank")
        expect(page).to have_content("Last name can't be blank")
        expect(page).to have_content("Email can't be blank")
      end
    end
  end

end
