class WelcomeController < ApplicationController

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

end
