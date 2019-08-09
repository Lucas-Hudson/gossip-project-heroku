class GossipsController < ApplicationController

  before_action :authenticate_user, only: [:index, :show, :create, :new]
  include SessionsHelper

  def index
    @gossips = Gossip.all
    @comment = Comment.all
  end

  def show
    @gossip = Gossip.find(params[:id])
    @comment = Comment.new
    @user = current_user
  end

  def new
    @gossip = Gossip.new
  end

  def create
    @user = current_user
    @gossip = Gossip.new(:user => @user, :title => params[:title], :content => params[:content])
      if @gossip.save
        redirect_to root_path
      else
        render new_gossip_path
      end
  end

  def edit
    @gossip = Gossip.find(params[:id])
  end

  def update
    @gossip = Gossip.find(params[:id])
    gossip_params = params.require(:gossip).permit(:title, :content)
      if @gossip.update(gossip_params)
          redirect_to gossip_path
      else
          render :edit
      end
  end


  def destroy
  @gossip = Gossip.find(params[:id])
  @gossip.destroy
  redirect_to gossips_path
  end

  private

  def authenticate_user
    unless current_user
      flash[:danger] = "Please log in."
      redirect_to new_session_path
    end
  end

end
