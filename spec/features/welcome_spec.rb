require 'rails_helper'

describe 'Welcome pages -' do
  scenario 'User is welcomed on homepage' do
    visit '/'
    within '.navbar' do
      expect(page).to have_content('gCamp')
    end
    within '.jumbotron' do
      expect(page).to have_content('gCamp')
      expect(page).to have_content('Your life, organized.')
    end
  end
end
