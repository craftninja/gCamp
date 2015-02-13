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

  scenario 'User can edit and delete projects' do
    visit '/projects'
    click_on 'New Project'
    fill_in 'Name', with: 'Create a sweet web app'
    click_on 'Create Project'
    click_on 'Edit'
    fill_in 'Name', with: 'Create an awesome web app'
    click_on 'Update Project'
    expect(page).to_not have_content('Create a sweet web app')
    expect(page).to have_content('Create an awesome web app')
    expect(page).to have_content('Project was successfully updated')
    click_on 'Delete'
    within '.page-header' do
      expect(page).to have_content('Projects')
    end
    expect(page).to_not have_content('Create an awesome web app')
    expect(page).to have_content('Project was successfully deleted')
  end

end
