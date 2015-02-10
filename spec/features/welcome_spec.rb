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

  scenario 'User can see the about page' do
    copy = "We are dedicated to the makers, the creators, the risk-takers. We wake up in the middle of the night and furiously write down ideas about how to make your online life better. Human collaboration and communication is what drives us, and it infuses every feature of gCamp."

    visit '/'
    click_on 'About'
    within '.page-header' do
      expect(page).to have_content('About')
    end
    within '.row' do
      within '.col-md-8' do
        expect(page).to have_content(copy)
      end
    end
  end
end
