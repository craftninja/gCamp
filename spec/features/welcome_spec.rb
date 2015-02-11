require 'rails_helper'

describe 'Welcome pages -' do
  scenario 'User is welcomed on homepage' do
    quotes = "gCamp has changed my life! It's the best tool I've ever used. - Carla Hayes Before gCamp I was a disorderly slob. Now I'm more organized than I've ever been. - Leta Jaskolski Don't hesitate - sign up right now! You'll never be the same. - Laverne Upton"
    visit '/'
    within '.navbar' do
      expect(page).to have_content('gCamp')
    end
    within '.jumbotron' do
      expect(page).to have_content('gCamp')
      expect(page).to have_content('Your life, organized.')
    end
    expect(page).to have_content(quotes)
  end

  scenario 'User can see the about page' do
    copy = "We are dedicated to the makers, the creators, the risk-takers. We wake up in the middle of the night and furiously write down ideas about how to make your online life better. Human collaboration and communication is what drives us, and it infuses every feature of gCamp."

    visit '/'
    click_on 'About'
    within '.page-header' do
      expect(page).to have_content('About')
    end
    within '.col-md-8' do
      expect(page).to have_content(copy)
    end
  end

  scenario 'User can see the terms page' do
    copy = "gCamp is not responsible for anything, unless it is positive. You many not take us to court. For anything. Ever."

    visit '/'
    click_on 'Terms'
    within '.page-header' do
      expect(page).to have_content('Terms')
    end
    expect(page).to have_content(copy)
  end
end
