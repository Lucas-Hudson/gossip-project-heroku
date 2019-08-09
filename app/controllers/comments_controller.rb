class CommentsController < ApplicationController

  include SessionsHelper
  before_action :authenticate_user, only: [:index, :show, :create, :new]
  def new
    @comment = Comment.new
    @gossip = Gossip.find(params[:gossip_id])

    puts "n" * 100
  end

  def create
    @user = current_user

    @gossip = Gossip.find(params[:gossip_id])

    # @gossip = Gossip.create(:user => User.all.sample, :title => params[:title], :content => params[:content])
    # redirect_to root_path
      #@comment = Comment.new(:user_id => User.all.sample, :commentable_type => "Gossip", :commentable_id => params[:gossip_id], :content => params[:content]) # avec xxx qui sont les données obtenues à partir du formulaire
      @comment = Comment.new(:user => @user, :commentable => @gossip, :content => params[:content])
      if @comment.save # essaie de sauvegarder en base @gossip
        redirect_to gossip_path(@gossip.id) # si ça marche, il redirige vers la page d'index du site
      else
        # sinon, il render la view new (qui est celle sur laquelle on est déjà)
        render new_gossip_path
      end
  end

  def edit
    @comment = Comment.find(params[:id])
    @gossip = Gossip.find(params[:gossip_id])

  end

def update
  puts "$" * 100
  puts @gossip
  puts "$" * 100
  @comment = Comment.find(params[:id])
  comment_params = params.require(:comment).permit(:content)
   if @comment.update(comment_params)
      redirect_to root_path
  else
      render :edit
  end
  # Méthode qui met à jour le potin à partir du contenu du formulaire de edit.html.erb, soumis par l'utilisateur
  # pour info, le contenu de ce formulaire sera accessible dans le hash params
  # Une fois la modification faite, on redirige généralement vers la méthode show (pour afficher le potin modifié)
end

private

def authenticate_user
  unless current_user
    flash[:danger] = "Please log in."
    redirect_to new_session_path
  end
end

end
