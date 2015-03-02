require 'rails_helper'

feature 'Projects -' do

  scenario 'Guests cannot see projects' do
    project = create_project
    visit root_path
    within 'footer' do
      expect(page).to_not have_content('Projects')
    end
    visit projects_path
    expect(page).to have_content('Sign into gCamp')
    visit project_path(project)
    expect(page).to have_content('Sign into gCamp')
    visit new_project_path
    expect(page).to have_content('Sign into gCamp')
    visit edit_project_path(project)
    expect(page).to have_content('Sign into gCamp')
  end

  scenario 'User can create projects, view project show, and see projects listed on index' do
    login
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
    within '.breadcrumb' do
      expect(page).to have_content('Projects Create a sweet web app')
    end
    expect(page).to have_link('Edit')
    expect(page).to have_link('Delete')
    visit projects_path
    click_on 'Create a sweet web app'
    within '.page-header' do
      expect(page).to have_content('Create a sweet web app')
    end
  end

  scenario 'User can edit and delete projects' do
    login
    visit '/projects'
    click_on 'New Project'
    within '.breadcrumb' do
      expect(page).to have_content('Projects New Project')
    end
    fill_in 'Name', with: 'Create a sweet web app'
    click_on 'Create Project'
    click_on 'Edit'
    within '.breadcrumb' do
      expect(page).to have_content('Projects Create a sweet web app Edit')
    end
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

  scenario 'User must enter project name' do
    login
    visit projects_path
    click_on 'New Project'
    click_on 'Create Project'
    within '.alert.alert-danger' do
      expect(page).to have_content('1 error prohibited this form from being saved')
      within 'ul li' do
        expect(page).to have_content("Name can't be blank")
      end
    end
  end

  scenario 'User can see number of tasks, link to tasks index for each project' do
    project = create_project
    login
    visit projects_path
    within '.table' do
      expect(page).to have_link('0')
    end
    task = create_task(project)
    visit projects_path
    within '.table' do
      click_on '1'
    end
    within '.page-header' do
      expect(page).to have_content("Tasks for #{project.name}")
    end
  end


end
