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
    click_on 'Create Task'
    expect(page).to have_content('Task was successfully created')
    expect(page).to have_content('Description: Write amazing tests')
    click_on 'Tasks'
    expect(page).to have_content('Write amazing tests')
    click_on 'Show'
    expect(page).to have_content('Description: Write amazing tests')
  end

end
