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
    :password => "#{rand(100..999)}",
    :admin => false,
    :pivotal_tracker_token => nil
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

def create_membership(project = create_project, user = create_user, options = {})
  Membership.create!({
    :project_id => project.id,
    :user_id => user.id,
    :role => :member
  }.merge(options))
end

def create_comment(task = create_task, user = create_user, options = {})
  Comment.create!({
    :content => "#{task.description} comment #{rand(100..999)}",
    :task_id => task.id,
    :user_id => user.id,
  }.merge(options))
end
