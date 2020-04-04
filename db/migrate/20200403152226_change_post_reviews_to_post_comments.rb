class ChangePostReviewsToPostComments < ActiveRecord::Migration[5.2]
  def change
    rename_table :post_reviews, :post_comments
  end
end
