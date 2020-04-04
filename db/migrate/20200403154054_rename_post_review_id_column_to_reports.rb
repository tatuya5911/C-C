class RenamePostReviewIdColumnToReports < ActiveRecord::Migration[5.2]
  def change
    rename_column :reports, :post_review_id, :post_comment_id
  end
end
