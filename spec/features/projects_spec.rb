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

  scenario 'Non-members cannot access projects' do
    project = create_project

    login
    visit project_path(project)
    expect(page).to have_content("You do not have access to that project")
    expect(current_path).to eq(projects_path)
  end

  scenario 'Members cannot edit, update or delete projects' do
    member = create_user
    project = create_project
    create_membership(project, member, :role => :member)
    login(member)
    visit project_path(project)
    expect(page).to_not have_content('Edit')
    expect(page).to_not have_content('Delete')
    visit edit_project_path(project)
    expect(current_path).to eq(project_path(project))
    expect(page).to have_content('You do not have access')
  end

  scenario 'User can create projects, view project show, and see projects listed on index' do
    login
    visit '/'
    within 'footer' do
      click_on 'Projects'
    end
    within '.page-header' do
      expect(page).to have_content('Projects')
      click_on 'New Project'
    end
    fill_in 'Name', with: 'Create a sweet web app'
    expect(page).to have_link('Cancel')
    click_on 'Create Project'
    within '.page-header' do
      expect(page).to have_content('Tasks for Create a sweet web app')
    end
    expect(page).to have_content('Project was successful created')
    within '.breadcrumb' do
      expect(page).to have_content('Projects Create a sweet web app Tasks')
      click_on 'Create a sweet web app'
    end
    expect(page).to have_content('1 Membership')
    expect(page).to have_link('Edit')
    expect(page).to have_link('Delete')
    visit projects_path
    within 'table' do
      click_on 'Create a sweet web app'
    end
    within '.page-header' do
      expect(page).to have_content('Create a sweet web app')
    end
  end

  scenario 'Users with Pivotal Tracker Tokens can see Tracker projects, stories' do
    user = create_user(:pivotal_tracker_token => ENV['PIVOTAL_TRACKER_TOKEN'])
    login(user)
    visit projects_path
    expect(page).to have_content('Pivotal Tracker Projects')
    expect(all('table')[1].all('a').count > 0).to be(true)
    all('table')[1].all('a').first.click
    within '.page-header' do
      expect(page).to have_content('Stories for')
    end
    within 'table' do
      expect(all('a').count > 0).to be(true)
    end
  end

  scenario 'Owners can edit and delete projects' do
    login
    visit '/projects'
    within '.page-header' do
      click_on 'New Project'
    end
    within '.breadcrumb' do
      expect(page).to have_content('Projects New Project')
    end
    fill_in 'Name', with: 'Create a sweet web app'
    click_on 'Create Project'

    project = Project.find_by(:name => 'Create a sweet web app')
    visit project_path(project)
    within '.well' do
      expect(page).to have_content('Deleting this project will also delete 1 membership, 0 tasks and associated comments')
    end

    3.times do
      create_membership(project)
    end
    create_task(project)

    click_on 'Edit'
    within '.breadcrumb' do
      expect(page).to have_content('Projects Create a sweet web app Edit')
    end
    fill_in 'Name', with: 'Create an awesome web app'
    click_on 'Update Project'
    expect(page).to_not have_content('Create a sweet web app')
    expect(page).to have_content('Create an awesome web app')
    expect(page).to have_content('Project was successfully updated')
    within '.well' do
      expect(page).to have_content('Deleting this project will also delete 4 memberships, 1 task and associated comments')
      click_on 'Delete'
    end
    within '.page-header' do
      expect(page).to have_content('Projects')
    end
    expect(page).to_not have_content('Create an awesome web app')
    expect(page).to have_content('Project was successfully deleted')
  end

  scenario 'Users can only see projects they are members of' do
    user = create_user
    my_project = create_project
    create_membership(my_project, user)

    other_user = create_user
    other_project = create_project
    create_membership(other_project, other_user)

    login(user)
    visit projects_path
    expect(page).to have_content(my_project.name)
    expect(page).to_not have_content(other_project.name)
  end

  scenario 'User must enter project name' do
    login
    visit projects_path
    within '.page-header' do
      click_on 'New Project'
    end
    click_on 'Create Project'
    within '.alert.alert-danger' do
      expect(page).to have_content('1 error prohibited this form from being saved')
      within 'ul li' do
        expect(page).to have_content("Name can't be blank")
      end
    end
  end

  scenario 'User can see number of tasks, link to tasks index for each project' do
    user = create_user
    project = create_project
    create_membership(project, user)

    login(user)
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

  scenario 'Project associated memberships, tasks and comments deleted upon project delete' do
    9.times do
      create_user
    end

    3.times do
      project = create_project
      2.times do
        task = create_task(project)
        3.times do
          create_comment(task, User.all.sample)
        end
      end
      users = User.all.map {|user| user}
      4.times do
        create_membership(project, users.delete(users.sample))
      end
    end

    project = Project.first

    visit about_path
    within '.col-md-12' do
      expect(page).to have_content('gCamp is extremely active. Check out our killer stats below!')
      expect(page).to have_content('3 Projects, 6 Tasks, 12 Project Members, 9 Users, 18 Comments')
    end

    project.destroy
    visit about_path
    within '.col-md-12' do
      expect(page).to have_content('gCamp is extremely active. Check out our killer stats below!')
      expect(page).to have_content('2 Projects, 4 Tasks, 8 Project Members, 9 Users, 12 Comments')
    end
  end

end
