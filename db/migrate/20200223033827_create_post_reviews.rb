class CreatePostReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :post_reviews do |t|
      t.integer :user_id
      t.integer :post_id
      t.string :title
      t.text :comment
      t.float :rate

      t.timestamps
    end
  end
end
