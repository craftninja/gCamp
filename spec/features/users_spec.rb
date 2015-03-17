require 'rails_helper'

feature 'Users -' do

  scenario 'Guests cannot see users' do
    user = create_user
    visit root_path
    within 'footer' do
      expect(page).to_not have_content('Users')
    end
    visit users_path
    expect(page).to have_content('You must sign in')
    expect(page).to have_content('Sign into gCamp')
    visit user_path(user)
    expect(page).to have_content('You must sign in')
    expect(page).to have_content('Sign into gCamp')
    visit new_user_path
    expect(page).to have_content('You must sign in')
    expect(page).to have_content('Sign into gCamp')
    visit edit_user_path(user)
    expect(page).to have_content('You must sign in')
    expect(page).to have_content('Sign into gCamp')
  end

  scenario 'Users cannot edit other users, see their email' do
    user = create_user
    other_user = create_user

    login(user)

    visit users_path
    expect(page).to have_content('Edit', count: 1)
    expect(page).to_not have_content(other_user.email)
    click_on other_user.full_name
    expect(page).to_not have_content('Edit')
    expect(page).to_not have_content(other_user.email)
    visit edit_user_path(other_user)
    expect(page).to have_content("The page you were looking for doesn't exist")
  end

  scenario 'Users can create users, see user show' do
    login
    fname = 'Luke'
    lname = 'Bartel'
    email = 'luke@example.com'
    password = 'password'

    visit '/'
    click_on 'Users'
    click_on 'New User'
    fill_in 'First Name', with: fname
    fill_in 'Last Name', with: lname
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    fill_in 'Password Confirmation', with: password
    expect(page).to have_link('Cancel')
    click_on 'Create User'
    within '.page-header' do
      expect(page).to have_content('Users')
    end

    expect(page).to_not have_link(email)
    click_on "#{fname} #{lname}"
    within '.page-header' do
      expect(page).to have_content("#{fname} #{lname}")
    end
    expect(page).to_not have_link(email)
  end

  scenario 'Users can update self' do
    user = create_user
    login(user)
    fname = 'Luke'
    lname = 'Bartel'
    password = 'password'

    visit edit_user_path(user)
    fill_in 'First Name', with: fname
    fill_in 'Last Name', with: lname
    fill_in 'Email', with: "#{lname}@example.com"
    click_on 'Update User'
    expect(page).to have_content("#{fname} #{lname}")
    expect(page).to have_content("#{lname}@example.com")
  end

  scenario 'User must enter first name, last name and email' do
    login
    visit users_path
    click_on 'New User'
    click_on 'Create User'
    within '.alert.alert-danger' do
      expect(page).to have_content('4 errors prohibited this form from being saved')
      within 'ul' do
        expect(page).to have_content("First name can't be blank")
        expect(page).to have_content("Last name can't be blank")
        expect(page).to have_content("Email can't be blank")
        expect(page).to have_content("Password can't be blank")
      end
    end
  end

end
