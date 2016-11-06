class RemoveUserAttributes < ActiveRecord::Migration
  def change
    remove_column :users, :email, :string
    remove_column :users, :avatar, :string
  end
end
