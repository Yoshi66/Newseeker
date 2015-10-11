class AddHostToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :host, :string
  end
end
