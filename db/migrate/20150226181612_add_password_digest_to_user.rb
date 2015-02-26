class AddPasswordDigestToUser < ActiveRecord::Migration

	class MigrationUser < ActiveRecord::Base
		self.table_name = :users
	end

  def change
    add_column :users, :password_digest, :string
	  MigrationUser.reset_column_information
    MigrationUser.all.each do |user|
      user.update(password: 'password')
    end
    change_column_null :users, :password_digest, false
  end
end
