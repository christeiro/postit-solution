class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]
  def index
    @posts = Post.all
  end

  def create
    @post = Post.new(post_params)
    @post.creator = User.first # TODO once we have authentication
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

  private 
  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def set_post
    @post = Post.find(params[:id])
  end

end