class AddAdminToUser < ActiveRecord::Migration

  class MigrationUser < ActiveRecord::Base
    self.table_name = :users
  end

  def change
    add_column :users, :admin, :boolean, default: false
	  MigrationUser.reset_column_information
    MigrationUser.all.each do |user|
      user.update(admin: false)
    end
    change_column_null :users, :admin, false
  end

end
