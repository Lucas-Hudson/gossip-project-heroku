class GossipsController < ApplicationController

  include SessionsHelper
  before_action :authenticate_user, only: [:index, :show, :create, :new]


  def index
    @gossips = Gossip.all
  end

  def show
    @gossip = Gossip.find(params[:id])
    @comment = Comment.new
    @user = current_user
    #@comment_id = Comment.find(params[:id])
  end

  def new
    @gossip = Gossip.new
  end

  def create
    @user = current_user
    # @gossip = Gossip.create(:user => User.all.sample, :title => params[:title], :content => params[:content])
    # redirect_to root_path
      @gossip = Gossip.new(:user => @user, :title => params[:title], :content => params[:content]) # avec xxx qui sont les données obtenues à partir du formulaire

      if @gossip.save # essaie de sauvegarder en base @gossip
        redirect_to root_path # si ça marche, il redirige vers la page d'index du site
      # else if current_user == nil
      #  redirect_to new_session_path
      else
        # sinon, il render la view new (qui est celle sur laquelle on est déjà)
        render new_gossip_path
      end
    # end
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
    # Méthode qui met à jour le potin à partir du contenu du formulaire de edit.html.erb, soumis par l'utilisateur
    # pour info, le contenu de ce formulaire sera accessible dans le hash params
    # Une fois la modification faite, on redirige généralement vers la méthode show (pour afficher le potin modifié)
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
