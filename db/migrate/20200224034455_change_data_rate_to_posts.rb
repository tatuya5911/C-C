class ChangeDataRateToPosts < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :rate, :integer
  end
end
