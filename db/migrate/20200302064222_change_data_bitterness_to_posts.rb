class ChangeDataBitternessToPosts < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :bitterness, :integer
  end
end
