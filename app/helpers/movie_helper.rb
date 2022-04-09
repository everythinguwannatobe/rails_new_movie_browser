module MovieHelper

  def movie_genre_names(genre_ids)
    genre_names = []

    if genre_ids.instance_of?(String) # if `genre_ids` returns single genre_id
      name = Genre.movie_genre_list(genre).name
      genre_names.push(name)
    elsif genre_ids.instance_of?(Array) # where genre_ids is array
      genre_ids.each do |genre|
        name = Genre.movie_genre_list(genre).name
        genre_names.push(name)
      end
    end
    genre_names.join(", ")
  end
end
