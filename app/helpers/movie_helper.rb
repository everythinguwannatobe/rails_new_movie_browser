module MovieHelper

  def movie_genre_names(genre_ids)
    genre_names = []

    genre_data = Rails.cache.fetch("genre_data", expires_in: 7.days) do
      Genre.all
    end

    if genre_ids.instance_of?(String) # if `genre_ids` returns single genre_id
      name = genre_data.movie_genre_list(genre).name
      genre_names.push(name)
    elsif genre_ids.instance_of?(Array) # where genre_ids is array
      genre_ids.each do |genre|
        name = genre_data.movie_genre_list(genre).name
        genre_names.push(name)
      end
    end
    genre_names.join(", ")
  end
end
