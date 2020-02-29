class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.integer :post_review_id
      t.integer :user_id
      t.integer :body

      t.timestamps
    end
  end
end
