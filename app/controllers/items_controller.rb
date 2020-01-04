class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.all
  end

  def show
  end

  def new
    @item = Item.new
    @images = build_images
  end

  def create
    @images = build_images
    @item = current_user.items.new(item_params)

    respond_to do |format|
      if handle_item_and_image!(@item, @images, "create")
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @images = build_images
  end

  def update
    @images = build_images

    respond_to do |format|
      if handle_item_and_image!(@item, @images, "update")
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to manage_items_path, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def manage
    @items = current_user.items
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:title, :status, :price, :lecture, :teacher, :memo, :user_id)
  end

  def build_images
    if params[:item].nil? || params[:item][:images].nil?
      Array.new(IMAGES_NUM, Image.new)
    else
      [
        Image.new(path: params[:item][:images][:img_0]),
        Image.new(path: params[:item][:images][:img_1]),
        Image.new(path: params[:item][:images][:img_2])
      ]
    end
  end

  def handle_item_and_image!(item, images, action)
    ActiveRecord::Base.transaction do
      case action
      when "create"
        item.save!
      when "update"
        item.update!(item_params)
      end
      update_images!(images)
      true
    end
  rescue => e
    @item.errors.add(:images, e.message) if e.message.include?("Path File size")
    false
  end

  def update_images!(images)
    images.each_with_index do |img, idx|
      img.item_id = @item.id
      img.save! if params[:item][:images].present? && params[:item][:images]["img_#{idx}"].present?
    end

    Image.find(params[:remove_img_0]).destroy! if params[:remove_img_0].present?
    Image.find(params[:remove_img_1]).destroy! if params[:remove_img_1].present?
    Image.find(params[:remove_img_2]).destroy! if params[:remove_img_2].present?
  end
end
