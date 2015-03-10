namespace :cleaner do

  desc 'clear database of invalid memberships'
  task memberships: :environment do
    Membership.where.not(user_id: User.all).delete_all
    Membership.where.not(project_id: Project.all).delete_all
  end

  desc 'clear database of invalid tasks'
  task tasks: :environment do
    Task.where.not(project_id: Project.all).delete_all
  end

  desc 'clear database of invalid comments'
  task comments: :environment do
    Comment.where.not(task_id: Task.all).delete_all
    Comment.where.not(user_id: User.all).update_all(user_id: nil)
  end

end
