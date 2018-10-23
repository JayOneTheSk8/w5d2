class SubsController < ApplicationController

  before_action :ensure_moderator, only: [:edit, :update, :destroy]

  def new
    if current_user
      @sub = Sub.new
      render :new
    else
      redirect_to new_session_url
    end
  end

  def create
    @sub = current_user.subs.new(sub_params)
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      @sub = Sub.new(title: params[:sub][:title], description: params[:sub][:description])
      render :new
    end
  end

  def index
    render :index
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      @sub = Sub.new(title: params[:sub][:title], description: params[:sub][:description])
      render :edit
    end
  end

  def destroy
    subreddit = Sub.find(params[:id])
    subreddit.destroy
    redirect_to subs_url
  end

  private

  def ensure_moderator
    subreddit = Sub.find_by(id: params[:id])
    unless subreddit.moderator == current_user
      flash[:errors] = ['You are not the moderator.']
      redirect_to sub_url(params[:id])
    end
  end

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
