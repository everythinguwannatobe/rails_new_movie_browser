module Tmdb
  class Client
    include HttpStatusCodes
    include ApiExceptions

    BASE_URL = "https://api.themoviedb.org/3/"
    API_KEY = Rails.application.credentials.tmdb.dig(:api_key)

    def client_params
      {
        language: @language,
        page: @page,
        api_key: API_KEY
      }
    end

    private

    def client
      @client ||= Faraday.new(BASE_URL) do |conn|
        conn.url_prefix = BASE_URL
        conn.use Faraday::HttpCache, store: Rails.cache, logger: Rails.logger
        conn.request :json
        conn.response :json, content_type: "application/json"
      end
    end

    def get_request(http_method:, endpoint:, params: {})
      response = client.public_send(http_method, endpoint, params)
      parsed_response = response.body

      return parsed_response if response_successful?(response)

      raise error_class, "Code: #{response.status}, response: #{response.body}"
    end

    def response_successful?(response)
      response.status == HTTP_OK_CODE
    end

    def api_requests_quota_reached?
      response.body.match?(ApiRequestsQuotaReachedError)
    end

    def error_class
      case response.status
      when HTTP_BAD_REQUEST_CODE
        BadRequestError
      when HTTP_UNAUTHORIZED_CODE
        UnauthorizedError
      when HTTP_FORBIDDEN_CODE
        return ApiRequestsQuotaReachedError if api_requests_quota_reached?
        ForbiddenError
      when HTTP_NOT_FOUND_CODE
        NotFoundError
      when HTTP_UNPROCESSABLE_ENTITY_CODE
        UnprocessableEntityError
      else
        ApiError
      end
    end
  end
end
