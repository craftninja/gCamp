def create_project(options = {})
  Project.create!({
    :name => "Project #{rand(100..999)}"
  }.merge(options))
end

def create_user(options = {})
  User.create!({
    :first_name => "Some #{rand(100..999)}",
    :last_name => "Person #{rand(100..999)}",
    :email => "person#{rand(1000..9999)}@example.com",
    :password => "#{rand(100..999)}"
  }.merge(options))
end

def create_task(project = create_project, options = {})
  Task.create!({
    :project_id => project.id,
    :description => "Do the thing #{rand(100..999)}",
    :completed => false,
    :due_date => Date.today + rand(10..20)
  }.merge(options))
end
