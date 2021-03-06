require 'rails_helper'

feature 'Comments -' do
  scenario 'Users can add comments to tasks' do
    user = create_user
    project = create_project
    create_membership(project, user)
    task = create_task(project)
    comment = 'That sounds like it will be really fun!'

    login(user)
    visit project_task_path(project, task)
    expect(page).to have_content('Comments')

    click_on 'Add Comment'
    expect(page).to_not have_content('less than a minute ago')
    expect(page).to have_content('Comments')
    fill_in :comment_content, with: comment
    click_on 'Add Comment'
    within '.col-md-3' do
      expect(page).to have_link(user.full_name)
      expect(page).to have_content('less than a minute ago')
    end
    expect(page).to have_content(comment)
  end

  scenario 'User can see number of comments associated with each task' do
    user = create_user
    login(user)
    project = create_project
    create_membership(project, user)
    task = create_task(project)
    9.times do
      create_comment(task, user)
    end

    visit project_tasks_path(project)

    within '.badge' do
      expect(page).to have_content('9')
    end
  end

  scenario 'When user is deleted, their comments author is (deleted user)' do
    commenter = create_user
    project = create_project
    create_membership(project, commenter)
    task = create_task(project)
    comment = create_comment(task, commenter)
    commenter.destroy

    user = create_user
    create_membership(project, user)
    login(user)
    visit project_task_path(project, task)
    expect(page).to have_content('(deleted user)')
  end
end
