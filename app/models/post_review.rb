class PostReview < ApplicationRecord

  has_many :reports

  belongs_to :user
  belongs_to :post
end
