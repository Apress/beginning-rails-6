class RemoveBodyFromArticles < ActiveRecord::Migration[6.0]
  def change

    remove_column :articles, :body, :text
  end
end
