module PostsHelper
  def user_post?
    current_user.id == Post.find(params[:id]).user_id
  end
end
