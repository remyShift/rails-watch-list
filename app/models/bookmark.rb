class Bookmark < ApplicationRecord
  belongs_to :movie
  belongs_to :list

  validates :comment, presence: true, length: { minimum: 6 }, allow_blank: false
  validates :movie_id, uniqueness: { scope: :list_id }
  validates :movie, presence: true
  validates :list, presence: true
end
