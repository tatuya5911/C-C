class Report < ApplicationRecord

  belongs_to :user
  belongs_to :post_review

  enum body: {性的な内容:1, 暴力的または不快な内容:2, 差別的または攻撃的な内容:3}

end
