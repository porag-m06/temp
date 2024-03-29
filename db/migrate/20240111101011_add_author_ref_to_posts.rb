class AddAuthorRefToPosts < ActiveRecord::Migration[7.1]
  def change
    add_reference :posts, :author, stored: true, null: false, foreign_key: { to_table: :users }
  end
end
