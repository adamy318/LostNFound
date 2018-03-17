class RemoveDateCreated < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :date_created
  end
end
