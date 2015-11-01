class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show]
  before_action :require_creator, only: [:edit, :update]

  def index
    @posts = Post.all.sort_by{ |x| x.total_votes}.reverse
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user
    if @post.save
      flash[:notice] = 'Your post was successfully created!'
      redirect_to :posts
    else
      render 'new'
    end
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def show
    @comment = Comment.new
  end

  def update
    if @post.update(post_params)
      flash[:notice] = 'Your post was successfully updated'
      redirect_to :post
    else
      render 'edit'
    end
  end

  def vote
    @vote = Vote.create(votable: @post, creator: current_user, vote: params[:vote])
    
    respond_to do |format|
      format.html do
        if @vote.valid?
          flash[:notice] = "You've voted!"
        else
          flash[:error] = "You've already voted!"
        end  
        redirect_to :back
      end
      format.js
    end
  end

  def require_creator
    access_denied unless logged_in? && (@post.creator == current_user || current_user.is_admin?)
  end

  private 
  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def set_post
    @post = Post.find_by(slug: params[:id])
  end
end