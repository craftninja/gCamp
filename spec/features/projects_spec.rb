require 'rails_helper'

feature 'Projects -' do

  scenario 'User can create projects, view project show, and see projects listed on index' do
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
    within '.page-header' do
      expect(page).to have_content('Create a sweet web app')
    end
    expect(page).to have_content('Project was successful created')
    expect(page).to have_link('Edit')
    expect(page).to have_link('Delete')
    click_on 'Projects'
    click_on 'Create a sweet web app'
    within '.page-header' do
      expect(page).to have_content('Create a sweet web app')
    end
  end

end
