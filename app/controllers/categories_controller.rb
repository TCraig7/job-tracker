class CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "#{@category.name} added!"
      redirect_to categories_path
    else
      flash[:failure] = 'Sorry, this category name already exists!'
      redirect_to new_category_path
    end
  end

  def edit
  end

  def update
    @category.update(category_params)

    redirect_to categories_path
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
