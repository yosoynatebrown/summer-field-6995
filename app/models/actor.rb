class Actor < ApplicationRecord
  has_many :actor_movies
  has_many :movies, through: :actor_movies

  def self.order_by_age
    order(:age)
  end

  def self.average_age
    average(:age).round(2)
  end

  def coactors
    coactors = []
    movies.each do |movie|
      movie.actors.each do |actor|
        coactors << actor
      end
    end
    coactors.uniq!
    coactors -= [self]
    coactors
  end
end
