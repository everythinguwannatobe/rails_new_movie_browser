module Tmdb
  class Genre < Client

    def initialize(language: "en-US", page: "1")
      @language = language
      @page = page
    end

    def list_movie_genre_ids
      get_request(
        http_method: :get,
        endpoint: "genre/movie/list",
        params: client_params
      )
    end

  end
end
