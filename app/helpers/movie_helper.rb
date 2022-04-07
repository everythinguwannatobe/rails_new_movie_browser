module MovieHelper

  def movie_genre_names(genre_ids)
    genre_names = []
    genre_list = Tmdb::Genre.new.movie_genre_list["genres"]

    if genre_ids.instance_of?(String) # if single genre_id
      genre_list.each do |list|
        if genre_ids == list["id"]
          genre_names.push(list["name"])
        end
      end
    elsif genre_ids.instance_of?(Array) # where genre_ids is array
      genre_ids.each do |genre|
        genre_list.each do |list|
          if list["id"] == genre
            genre_names.push(list["name"])
          end
        end
      end
    end
    genre_names.join(", ")
  end
end
