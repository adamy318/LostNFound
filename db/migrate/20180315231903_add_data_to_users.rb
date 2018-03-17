class AddDataToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :username, :string
    add_column :users, :email, :string
    add_column :users, :password_hash, :string
    add_column :users, :date_created, :datetime
  end
end
