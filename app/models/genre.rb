class Genre < ApplicationRecord

  def self.movie_genre_list(movie_genre_id)
    find_by(genre_id: movie_genre_id)
  end

end
