class BookmarksController < ApplicationController
  before_action :set_list, only: [:new, :create, :destroy]
  before_action :set_background_image, only: [:new, :create]

  def show
  end

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    list = @bookmark.list
    @bookmark.destroy
    redirect_to list_path(list), status: :see_other
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end

  def set_list
    @list = if params[:list_id]
      List.find(params[:list_id])
    else
      Bookmark.find(params[:id]).list
    end
  end

  def set_background_image
    @background_image = {
      classic: "https://as2.ftcdn.net/v2/jpg/02/39/24/45/1000_F_239244529_DvA47OXFQic9krRTFm49g9RUDPRTSIJV.jpg",
      horror: "https://w0.peakpx.com/wallpaper/192/414/HD-wallpaper-classic-movies-the-exorcist-classic-movies-horror-movies-the-exorcist-horror-films.jpg",
      action: "https://wallpapers.com/images/featured-full/action-movie-pb93e7r343erqgtt.jpg",
      comedy: "https://as1.ftcdn.net/v2/jpg/03/47/29/16/1000_F_347291628_iqN7R0mkUwCwDPDpUUE1C1PjvDm1JTes.jpg",
    }
  end
end
