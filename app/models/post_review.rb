class PostReview < ApplicationRecord

  has_many :reports, dependent: :destroy

  belongs_to :user
  belongs_to :post
end
