require 'rails_helper'

feature 'Projects -' do

  scenario 'User can create projects and see them listed on index' do
    visit '/'
    within 'footer' do
      click_on 'Projects'
    end
    within '.page-header' do
      expect(page).to have_content('Projects')
    end
    click_on 'New Project'
    fill_in 'Name', with: 'Create a sweet web app'
    expect(page).to have_link('Cancel')
    click_on 'Create Project'
    expect(page).to have_content('Create a sweet web app')
  end

end
