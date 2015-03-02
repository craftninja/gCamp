require 'rails_helper'

feature 'Memberships -' do
  scenario 'The project show has membership count link to projects memberships index' do
    user = create_user
    project = create_project
    login(user)
    visit project_path(project)
    click_on '0 Members'
    within '.page-header' do
      expect(page).to have_content("#{project.name}: Manage Members")
    end
    membership = create_membership(project, user)
    visit project_path(project)
    expect(page).to have_content('1 Member')
  end
end
