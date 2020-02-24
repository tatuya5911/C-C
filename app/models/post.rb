class Post < ApplicationRecord

  belongs_to :user
  belongs_to :category
  has_many :post_reviews

  attachment :post_image

  validates :post_title, presence: true, length: {maximum: 30 }
  validates :category_id, presence: true
  validates :aroma, presence: true
  validates :acidity, presence: true
  validates :rich, presence: true
  validates :bitterness, presence: true
  validates :rate, :numericality => { :less_than_or_equal_to => 100 }
  validates :body, presence: true, format: { with: /\A[a-z0-9]+\z/i }, length: {maximum: 200}

end
