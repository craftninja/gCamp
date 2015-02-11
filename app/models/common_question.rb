class CommonQuestion

  def initialize(question, answer)
    @question = question
    @answer = answer
    @slug = question.downcase.chomp('?').gsub(' ', '-')
  end

  def question
    @question
  end

  def slug
    @slug
  end

  def answer
    @answer
  end

end
