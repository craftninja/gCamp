class PivotalTracker

  def get_projects(token)
    data = send_request("/services/v5/projects", token)
    names_and_ids = {}

    data.each do |project|
      names_and_ids[project[:name]] = project[:id]
    end

    names_and_ids
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

end
