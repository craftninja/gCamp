require 'rails_helper'

describe 'User Auth -' do
  scenario 'User can sign up and sign out' do
    visit root_path
    click_on 'Sign Up'
    within '.well' do
      expect(page).to have_content('Sign up for gCamp!')
      fill_in 'First Name', with: 'Elowyn'
      fill_in 'Last Name', with: 'Florence'
      fill_in 'Email', with: 'elowyn@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password Confirmation', with: 'password'
      click_on 'Sign Up'
    end
    within '.navbar' do
      expect(page).to have_content('Elowyn Florence')
      expect(page).to_not have_content('Sign Up')
    end
    expect(page).to have_content('You have successfully signed up')
    within '.navbar' do
      click_on 'Sign Out'
    end
    within '.navbar' do
      expect(page).to_not have_content('Elowyn Florence')
      expect(page).to_not have_content('Sign Out')
      expect(page).to have_content('Sign Up')
    end
    expect(page).to have_content('You have successfully signed out')
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
