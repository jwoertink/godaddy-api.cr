require "http/client"
require "json"
require "./godaddy-api/*"

module Godaddy
  class API
    BASE_URL = "https://api.godaddy.com"

    def self.configure
      yield configuration
    end

    def self.configuration
      @@configuration ||= Configuration.new
    end

    def initialize
      @headers = HTTP::Headers.new
      @headers["Authorization"] = "sso-key #{API.configuration.api_key}:#{API.configuration.api_secret}"
      @headers["Content-Type"] = "application/json"
    end

    {% for method in ["get", "post", "put", "patch", "delete"] %}
      def {{method.id}}(path, payload = nil)
        response = HTTP::Client.{{method.id}}("#{BASE_URL}/#{API.configuration.version}" + path, headers: @headers, body: payload.to_json)
        JSON.parse(response.body)
      end
    {% end %}
  end
end
