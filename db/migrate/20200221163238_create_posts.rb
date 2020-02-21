class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :category_id
      t.string :post_image_id
      t.string :post_title
      t.text :body
      t.integer :aroma
      t.integer :acidity
      t.integer :rich
      t.string :bitterness
      t.float :rate

      t.timestamps
    end
  end
end
