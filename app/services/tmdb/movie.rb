module Tmdb
  class Movie < Client

    def initialize(language: "en-US", page: "1")
      @language = language
      @page = page
    end

    def popular
      get_request(
        http_method: :get,
        endpoint: "movie/popular",
        params: client_params
      )
    end

    def get_details(show_movie_id)
      get_request(
        http_method: :get,
        endpoint: "movie/#{show_movie_id}",
        params: client_params
      )
    end

  end
end
