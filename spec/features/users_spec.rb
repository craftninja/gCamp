require 'rails_helper'

feature 'Users -' do

  scenario 'Users can create users' do
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

    expect(page).to have_content("#{fname} #{lname}")
    expect(page).to have_link(email)
  end

end
