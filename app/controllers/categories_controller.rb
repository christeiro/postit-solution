class CategoriesController < ApplicationController
  before_action :require_user, except: [:show]
  before_action :require_admin, only: [:new, :create]
  
  def new
    binding.pry
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = 'Category created!'
      redirect_to :root
    else
      render 'new'
    end
  end

  def show
    @category = Category.find_by(slug: params[:id])
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end
end