class Post < ApplicationRecord

  belongs_to :user
  belongs_to :category
  has_many :post_reviews

  attachment :post_image
end
