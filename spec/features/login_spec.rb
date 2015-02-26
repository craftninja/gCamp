require 'rails_helper'

describe 'User Auth -' do
  scenario 'User can sign up, sign out, sign in' do
    first_name = 'Elowyn'
    last_name = 'Florence'
    email = "#{first_name}@example.com"
    password = 'password'

    visit root_path
    click_on 'Sign Up'
    within '.well' do
      expect(page).to have_content('Sign up for gCamp!')
      fill_in 'First Name', with: first_name
      fill_in 'Last Name', with: last_name
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      fill_in 'Password Confirmation', with: password
      click_on 'Sign Up'
    end
    within '.navbar' do
      expect(page).to have_content("#{first_name} #{last_name}")
      expect(page).to_not have_content('Sign Up')
    end
    expect(page).to have_content('You have successfully signed up')
    within '.navbar' do
      click_on 'Sign Out'
    end
    within '.navbar' do
      expect(page).to_not have_content("#{first_name} #{last_name}")
      expect(page).to_not have_content('Sign Out')
      expect(page).to have_content('Sign Up')
    end
    expect(page).to have_content('You have successfully signed out')
    click_on 'Sign In'
    within '.well' do
      expect(page).to have_content('Sign into gCamp')
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      click_on 'Sign In'
    end
    expect(page).to have_content('You have successfully signed in')
    expect(page).to have_content("#{first_name} #{last_name}")
  end

  scenario 'User must enter first name, last name, email, password, password confirmation' do
    visit root_path
    click_on 'Sign Up'
    within '.well' do
      click_on 'Sign Up'
    end
    expect(page).to have_content("First name can't be blank Last name can't be blank Email can't be blank Password can't be blank")
  end
end
