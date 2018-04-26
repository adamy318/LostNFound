class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def show
    @post = Post.find(params[:id])
  end

  def create

    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  private def post_params
    params.require(:post).permit(:title, :body, :image, :comments, :user)
  end
end
