# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

genres = Tmdb::Genre.new.list_movie_genre_ids
genres["genres"].each do |genre|
  Genre.find_or_create_by(
    genre_id: genre["id"].to_s,
    name: genre["name"]
  )
end


