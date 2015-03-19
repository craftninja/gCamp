class PivotalTracker

  def get_projects(token)
    data = send_request("/services/v5/projects", token)
    names_and_ids = {}

    data.each do |project|
      names_and_ids[project[:name]] = project[:id]
    end

    names_and_ids
  end

  def get_stories(project_id, token)
    stories = multiple_requests('with_state=rejected', 'with_state=started', 'with_state=unstarted',
      'with_state=finished', 'with_state=delivered', 'with_state=accepted', project_id, token)
    stories = sort_stories(stories)
  end

  def send_request(path, token)
    conn = Faraday.new(url: "https://www.pivotaltracker.com")

    response = conn.get do |req|
      req.url path
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-TrackerToken'] = token
    end

    if response.success?
      response_json = JSON.parse(response.body, symbolize_names: true)
    end

    response_json
  end

  def multiple_requests(*queries, project_id, token)
    responses = []
    queries.each do |query|
      responses << send_request("/services/v5/projects/#{project_id}/stories?#{query}", token)
    end
    responses
  end

  def sort_stories(stories)
    sorted = []

    stories.each do |story|
      story.each do |data|
        sorted_story = {}

        sorted_story[:description]   = data[:name]
        sorted_story[:estimate]      = data[:estimate]
        sorted_story[:current_state] = data[:current_state]
        sorted_story[:labels]        = []
        data[:labels].each{|l| sorted_story[:labels] << l[:name]}

        sorted << sorted_story
      end
    end

    sorted
  end

end
