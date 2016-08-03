class ItemsController < ApplicationController
  before_action :find_item, only: [:show, :edit, :update, :destroy, :complete, :uncomplete]


  def index
    @items = Item.all.order(:created_at).reverse_order
  end

  def new
    @item = Item.new
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  def edit
  end


  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render 'edit'
    end
  end

  def show
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render 'new'
    end
  end



  def complete
    @item.update_attribute(:completed_at, Time.now)
    redirect_to root_path
  end

  def uncomplete
    @item.update_attribute(:completed_at, nil)
    redirect_to root_path
  end


  private

  def find_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:title, :description)
  end

end
