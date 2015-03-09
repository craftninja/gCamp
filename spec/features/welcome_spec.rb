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

  scenario 'User can see the about page, stats for site' do
    copy = "We are dedicated to the makers, the creators, the risk-takers. We wake up in the middle of the night and furiously write down ideas about how to make your online life better. Human collaboration and communication is what drives us, and it infuses every feature of gCamp."

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

    visit '/'
    click_on 'About'
    within '.page-header' do
      expect(page).to have_content('About')
    end
    within '.col-md-8' do
      expect(page).to have_content(copy)
    end
    within '.col-md-12' do
      expect(page).to have_content('gCamp is extremely active. Check out our killer stats below!')
      expect(page).to have_content('3 Projects, 6 Tasks, 12 Project Members, 9 Users, 18 Comments')
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

  scenario 'User can see the FAQ page' do
    q1 = 'What is gCamp?'
    a1 = "gCamp is an awesome tool that is going to change your life. gCamp is your one stop shop to organize all your tasks. You'll also be able to track comments that you and others make. gCamp may eventually replace all need for paper and pens in the entire world. Well, maybe not, but it's going to be pretty cool."
    q2 = 'How do I join gCamp?'
    a2 = "As soon as it's ready for the public, you'll see a signup link in the upper right. Once that's there, just click it and fill in the form!"
    q3 = 'When will gCamp be finished?'
    a3 = "gCamp is a work in progress. That being said, it should be fully functional in the next few weeks. Functional. Check in daily for new features and awesome functionality. It's going to blow your mind. Organization is just a click away. Amazing!"

    visit '/'
    click_on 'FAQ'
    within '.page-header' do
      expect(page).to have_content('Frequently Asked Questions')
    end
    expect(page).to have_link(q1)
    expect(page).to have_link(q2)
    expect(page).to have_link(q3)
    expect(page).to have_content(a1)
    expect(page).to have_content(a2)
    expect(page).to have_content(a3)
    expect(page).to have_link('top')
  end
end
