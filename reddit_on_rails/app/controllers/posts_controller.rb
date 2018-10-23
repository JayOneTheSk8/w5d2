class PostsController < ApplicationController

  before_action :ensure_author, only: [:edit, :update, :destroy]

  def new
    render :new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to post_url
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_url
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_url
  end

  # def method_name
  #
  # end

  private
  def ensure_author
    post = Post.find_by(id: params[:id])
    unless post.author == current_user
      flash[:errors] = ['You are not the author of this post. Therefore, you may not edit it']
      redirect_to post_url(params[:id])
    end
  end

  def post_params
    params.require(:post).permit(:title, :url, :content)
  end
end
