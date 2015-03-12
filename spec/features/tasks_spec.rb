require 'rails_helper'

feature 'Tasks -' do

  scenario 'Guests cannot see tasks' do
    project = create_project
    task = create_task(project)
    visit project_tasks_path(project)
    expect(page).to have_content('You must sign in')
    expect(page).to have_content('Sign into gCamp')
    visit project_task_path(project, task)
    expect(page).to have_content('You must sign in')
    expect(page).to have_content('Sign into gCamp')
    visit new_project_task_path(project)
    expect(page).to have_content('You must sign in')
    expect(page).to have_content('Sign into gCamp')
    visit edit_project_task_path(project, task)
    expect(page).to have_content('You must sign in')
    expect(page).to have_content('Sign into gCamp')
  end

  scenario "Non-members of the task's project cannot manage tasks" do
    member = create_user
    project = create_project
    create_membership(project, member)
    task = create_task(project)
    non_member = create_user
    login(non_member)

    visit project_tasks_path(project)
    expect(page).to have_content("You do not have access to that project")
    expect(current_path).to eq(projects_path)

    visit project_task_path(project, task)
    expect(page).to have_content("You do not have access to that project")
    expect(current_path).to eq(projects_path)
  end

  scenario 'Tasks are linked from projects with number of tasks assoc with project' do
    user = create_user
    project = create_project
    create_membership(project, user)
    login(user)
    within 'footer' do
      expect(page).to_not have_content('Tasks')
    end
    visit project_path(project)
    expect(page).to have_link('0 Tasks')

    create_task(project)
    visit project_path(project)
    expect(page).to have_link('1 Task')

    create_task(project)
    visit project_path(project)
    expect(page).to have_link('2 Tasks')
  end

  scenario 'User can create tasks and see them listed on index' do
    user = create_user
    project = create_project
    create_membership(project, user)

    login(user)
    visit root_path
    click_on 'Projects'
    within 'table' do
      click_on project.name
    end
    click_on '0 Tasks'
    within 'h1' do
      expect(page).to have_content("Tasks for #{project.name}")
    end
    within '.breadcrumb' do
      expect(page).to have_content("Projects #{project.name} Tasks")
    end
    expect(page).to have_content('Description')
    click_on 'New Task'
    within '.breadcrumb' do
      expect(page).to have_content("Projects #{project.name} Tasks New Task")
    end
    expect(page).to have_content('New Task')
    fill_in 'Description', with: 'Write amazing tests'
    fill_in 'Due date', with: Date.today
    click_on 'Create Task'
    expect(page).to have_content('Task was successfully created')
    within '.page-header' do
      expect(page).to have_content('Write amazing tests')
    end
    within '.breadcrumb' do
      expect(page).to have_content("Projects #{project.name} Tasks Write amazing tests")
    end
    today = Date.today
    month = today.month
    day = today.day
    year = today.year
    expect(page).to have_content("#{month}/#{day}/#{year}")
    visit project_tasks_path(project)

    expect(page).to have_content("#{month}/#{day}/#{year}")
    click_on 'Write amazing tests'
    expect(page).to have_content('Write amazing tests')
  end

  scenario 'User can edit, complete (only on edit form) and delete tasks' do
    user = create_user
    project = create_project
    create_membership(project, user)
    login(user)
    visit project_tasks_path(project)
    click_on 'New Task'
    fill_in 'Description', with: 'Refactor code'
    expect(page).to_not have_content('Complete')
    click_on 'Create Task'
    click_on 'Edit'
    within '.breadcrumb' do
      expect(page).to have_content("Projects #{project.name} Tasks Refactor code Edit")
    end
    fill_in 'Description', with: 'Refactor tests'
    check 'Complete'
    click_on 'Update Task'
    within 's' do
      expect(page).to have_content('Refactor tests')
    end
    visit project_tasks_path(project)
    within 's' do
      expect(page).to have_content('Refactor tests')
    end
    expect(page).to have_content('Edit')
    find('.glyphicon-remove').click
    expect(page).to_not have_content('Refactor tests')
  end

  scenario 'User must enter task description' do
    user = create_user
    project = create_project
    create_membership(project, user)
    login(user)
    visit project_tasks_path(project)
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
