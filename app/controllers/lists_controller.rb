class ListsController < ApplicationController
  before_action :set_list, only: [:show, :destroy]
  before_action :set_background_image, only: [:show]

  def index
    @lists = List.all
  end

  def show
    @bookmark = Bookmark.new
  end

  def new
    @list = List.new
    @movies = Movie.all
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @list.destroy
    redirect_to lists_path, status: :see_other
  end

  private

  def list_params
    params.require(:list).permit(:name, movie_ids: [])
  end

  def set_list
    @list = List.find(params[:id])
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
