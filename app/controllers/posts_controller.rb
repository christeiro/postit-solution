class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show]

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
    @post.categories = Category.all
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
    if @vote.valid?
      flash[:notice] = "You've voted!"
    else
      flash[:error] = "You've already voted!"
    end
    redirect_to :back
  end

  private 
  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def set_post
    @post = Post.find(params[:id])
  end
end