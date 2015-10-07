class AddPositionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :company, :string
    add_column :users, :position, :string
    add_column :users, :introduction, :text
  end
end
