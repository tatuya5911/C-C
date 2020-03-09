class PostReview < ApplicationRecord

  has_many :reports, dependent: :destroy

  belongs_to :user
  belongs_to :post

  validates :title, presence: true, length: {maximum: 35}
  validates :comment, presence: true, length: {maximum: 300}

end
