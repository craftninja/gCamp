require 'rails_helper'

feature 'Projects -' do

  scenario 'User can see project link in footer' do
    visit '/'
    within 'footer' do
      expect(page).to have_link('Projects')
    end
  end

end
