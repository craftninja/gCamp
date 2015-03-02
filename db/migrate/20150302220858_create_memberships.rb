class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.belongs_to :user, null: false
      t.belongs_to :project, null: false
      t.integer :role, default: 0, null: false
      t.timestamps null: false
    end
  end
end
