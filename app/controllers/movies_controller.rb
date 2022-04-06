class MoviesController < ApplicationController

  def index
    response = Tmdb::Movie.new.popular

    render locals: {
      movies: response["results"],
      current_page: response["page"],
      total_pages: response["total_pages"],
      total_results: response["total_results"]
    }

  end

end
