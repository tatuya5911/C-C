module ApplicationHelper

  def post_count
    Post.count
  end

  def categorys
    Category.all
  end

end
