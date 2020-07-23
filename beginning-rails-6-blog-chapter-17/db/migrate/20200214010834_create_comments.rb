class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :article, null: false, foreign_key: true
      t.string :name
      t.string :email
      t.text :body

      t.timestamps
    end
  end
end
