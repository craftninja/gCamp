class WelcomeController < PublicController

  def index
    @quotes = {
      'Carla Hayes' => "gCamp has changed my life! It's the best tool I've ever used.",
      'Leta Jaskolski' => "Before gCamp I was a disorderly slob. Now I'm more organized than I've ever been.",
      'Laverne Upton' => "Don't hesitate - sign up right now! You'll never be the same.",
    }
  end

  def about
  end

  def terms
  end

  def faq
    cq1 = CommonQuestion.new('What is gCamp?', "gCamp is an awesome tool that is going to change your life. gCamp is your one stop shop to organize all your tasks. You'll also be able to track comments that you and others make. gCamp may eventually replace all need for paper and pens in the entire world. Well, maybe not, but it's going to be pretty cool.")
    cq2 = CommonQuestion.new('How do I join gCamp?', "As soon as it's ready for the public, you'll see a signup link in the upper right. Once that's there, just click it and fill in the form!")
    cq3 = CommonQuestion.new('When will gCamp be finished?', "gCamp is a work in progress. That being said, it should be fully functional in the next few weeks. Functional. Check in daily for new features and awesome functionality. It's going to blow your mind. Organization is just a click away. Amazing!")
    @common_questions = [cq1, cq2, cq3]
  end

end
