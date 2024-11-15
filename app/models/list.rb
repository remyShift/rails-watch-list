class List < ApplicationRecord
  BACKGROUND_IMAGES = {
    classic: "https://as2.ftcdn.net/v2/jpg/02/39/24/45/1000_F_239244529_DvA47OXFQic9krRTFm49g9RUDPRTSIJV.jpg",
    horror: "https://w0.peakpx.com/wallpaper/192/414/HD-wallpaper-classic-movies-the-exorcist-classic-movies-horror-movies-the-exorcist-horror-films.jpg",
    action: "https://wallpapers.com/images/featured-full/action-movie-pb93e7r343erqgtt.jpg",
    comedy: "https://as1.ftcdn.net/v2/jpg/03/47/29/16/1000_F_347291628_iqN7R0mkUwCwDPDpUUE1C1PjvDm1JTes.jpg",
  }.freeze
  has_many :bookmarks, dependent: :destroy
  has_many :movies, through: :bookmarks
  has_one_attached :image
  validates :name, presence: true, uniqueness: true
  validate :validate_image

  def validate_image
    if !self.image.attached? && !self.class::BACKGROUND_IMAGES.keys.include?(self.name.downcase.to_sym)
      errors.add(:image, "you must provide an image")
    end
  end
end
