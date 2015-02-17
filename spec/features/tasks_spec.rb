require 'rails_helper'

feature 'Tasks -' do

  scenario 'User can create tasks and see them listed on index' do
    visit '/'
    click_on 'Tasks'
    within 'h1' do
      expect(page).to have_content('Tasks')
    end
    expect(page).to have_content('Description')
    click_on 'New Task'
    expect(page).to have_content('New Task')
    fill_in 'Description', with: 'Write amazing tests'
    fill_in 'Due date', with: Date.today
    click_on 'Create Task'
    expect(page).to have_content('Task was successfully created')
    within '.page-header' do
      expect(page).to have_content('Write amazing tests')
    end
    today = Date.today
    month = today.month
    day = today.day
    year = today.year
    expect(page).to have_content("#{month}/#{day}/#{year}")
    within 'footer' do
      click_on 'Tasks'
    end

    expect(page).to have_content("#{month}/#{day}/#{year}")
    click_on 'Write amazing tests'
    expect(page).to have_content('Write amazing tests')
  end

  scenario 'User can edit, complete (only on edit form) and delete tasks' do
    visit tasks_path
    click_on 'New Task'
    fill_in 'Description', with: 'Refactor code'
    expect(page).to_not have_content('Complete')
    click_on 'Create Task'
    click_on 'Edit'
    fill_in 'Description', with: 'Refactor tests'
    check 'Complete'
    click_on 'Update Task'
    within 's' do
      expect(page).to have_content('Refactor tests')
    end
    within 'footer' do
      click_on 'Tasks'
    end
    within 's' do
      expect(page).to have_content('Refactor tests')
    end
    expect(page).to have_content('Edit')
    click_on 'Delete'
    expect(page).to_not have_content('Refactor tests')
  end

  scenario 'User must enter task description' do
    visit tasks_path
    click_on 'New Task'
    click_on 'Create Task'
    within '.alert.alert-danger' do
      expect(page).to have_content('1 error prohibited this form from being saved')
      within 'ul li' do
        expect(page).to have_content("Description can't be blank")
      end
    end
  end

end
