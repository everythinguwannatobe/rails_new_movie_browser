class MoviesController < ApplicationController

  def index
    page = params["page"].nil? ? "1" : params["page"]
    response = Tmdb::Movie.new(page: page).popular

    @movies = response["results"]
    @current_page = response["page"]
    @total_pages = response["total_pages"]
    @total_results = response["total_results"]

  end

  def show
    response = Tmdb::Movie.new.get_details(params[:id])

    render locals: {
      movie: response
    }
  end

end
