class ProductionCompany < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :movies

  def self.ordered_by_movies
    self.select("production_companies.*")
    .select("COUNT(production_companies.id) as movie_count")
    .left_joins(:movies)
    .group("production_companies.id")
    .order("movie_count DESC")
  end
end
