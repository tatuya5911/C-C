class Post < ApplicationRecord

  belongs_to :user
  belongs_to :category
  has_many :post_reviews, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :browsing_histories, dependent: :destroy

  attachment :post_image

  validates :post_title, presence: true, length: {maximum: 30 }
  validates :category_id, presence: true
  validates :aroma, presence: true
  validates :acidity, presence: true
  validates :rich, presence: true
  validates :bitterness, presence: true
  validates :rate, :numericality => { :less_than_or_equal_to => 100 }, format: { with: /\A[a-z0-9]+\z/i }
  validates :body, presence: true, length: {maximum: 200}

end
