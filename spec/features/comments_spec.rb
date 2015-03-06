require 'rails_helper'

feature 'Comments -' do
  scenario 'Users can add comments to tasks' do
    user = create_user
    login(user)
    project = create_project
    task = create_task
    comment = 'That sounds like it will be really fun!'
    visit project_task_path(project, task)

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
end
