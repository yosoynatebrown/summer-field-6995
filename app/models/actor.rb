class Actor < ApplicationRecord
  has_many :actor_movies
  has_many :movies, through: :actor_movies

  scope :order_by_age, -> { order(:age) }
  scope :average_age, -> { average(:age).round(2) }

  def coactors
    movie_ids = ActorMovie.where(actor_id: self.id).pluck(:movie_id)
    actor_ids = ActorMovie.where(movie_id: movie_ids).pluck(:actor_id)
    Actor.where(id: actor_ids).where.not(id: self.id).distinct
  end
end
