class CommentsController < ApplicationController

  before_action :authenticate_user, only: [:index, :show, :create, :new]
  include SessionsHelper

  def new
    @comment = Comment.new
    @gossip = Gossip.find(params[:gossip_id])
  end

  def create
    @user = current_user
    @gossip = Gossip.find(params[:gossip_id])
    @comment = Comment.new(:user => @user, :commentable => @gossip, :content => params[:content])

      if @comment.save
        redirect_to gossip_path(@gossip.id)
      else
        render new_gossip_path
      end
  end

  def edit
    @comment = Comment.find(params[:id])
    @gossip = Gossip.find(params[:gossip_id])
  end

  def update
    @comment = Comment.find(params[:id])
    comment_params = params.require(:comment).permit(:content)

     if @comment.update(comment_params)
        redirect_to root_path
    else
        render :edit
    end
  end

  private

  def authenticate_user
    unless current_user
      flash[:danger] = "Please log in."
      redirect_to new_session_path
    end
  end

end
