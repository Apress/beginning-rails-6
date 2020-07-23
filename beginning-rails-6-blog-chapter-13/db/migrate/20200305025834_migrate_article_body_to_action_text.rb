class MigrateArticleBodyToActionText < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      INSERT INTO action_text_rich_texts (
        name,
        body,
        record_type,
        record_id,
        created_at,
        updated_at
      ) SELECT
        'body' AS name,
        body,
        "Article",
        id,
        created_at,
        updated_at
      FROM articles
    SQL
  end

  def down
    execute <<-SQL
      DELETE FROM action_text_rich_texts
    SQL
  end
end
