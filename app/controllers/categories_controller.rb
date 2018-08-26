class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    category = Category.new(category_params)
    if category.save
      flash[:success] = "#{category.name} added!"
      redirect_to categories_path
    else
      flash[:failure] = 'Sorry, this category name already exists!'
      redirect_to new_category_path
    end
  end

  def show
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:success] = "#{@category.name} added!"
      redirect_to categories_path
    else
      flash[:failure] = 'Sorry, this category name already exists!'
      redirect_to edit_category_path(@category)
    end
  end

  def destroy
    @category.destroy

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
