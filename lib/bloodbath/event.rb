require 'net/http'
require 'pry'
require 'json'

module Bloodbath
  class RestAdapter
    attr_reader :method, :endpoint, :body, :config

    def initialize(method:, endpoint:, body:, config: Bloodbath.config)
      @method = method
      @endpoint = endpoint
      @body = body
      @config = config
    end

    def perform
      check_api_key
      response
    end

    private

    def check_api_key
      unless config.api_key
        raise Bloodbath::Error, "Please set your API key through Bloodbath.api_key = 'my-api-key'"
      end
    end

    def response
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if uri.instance_of? URI::HTTPS

      request['Authorization'] = "Bearer #{config.api_key}"
      request['Content-Type'] = 'application/json'
      request.body = body.to_json

      response = http.request(request)
      JSON.parse(response.body, symbolize_names: true)
    end

    def uri
      @uri ||= URI("#{config.api_base}#{endpoint}")
    end

    def request
      @request ||= case method
      when :post
        Net::HTTP::Post
      when :get
        Net::HTTP::Get
      when :delete
        Net::HTTP::Delete
      when :patch
        Net::HTTP::Patch
      when :put
        Net::HTTP::Put
      end.new(uri.request_uri)
    end
  end
end

module Bloodbath
  class Event
    class << self
      def schedule(args)
        Bloodbath::RestAdapter.new(method: :post, endpoint: '/events', body: args).perform
      end
    end
  end
end


# curl \
#   -X POST -G \
#   -H "Authorization: Bearer CA3knhSEFs8OWzO1_186q7KT-0agve-pUOpzx7UoMzPjiC3Wd-nsIAQcG8vCR-RytaSiToDXNIU_zkLFXBGE1w==" \
#   -H "Content-Type: application/json" \
#   http://localhost:4000/rest/events/ \
#   -d scheduled_for=2021-05-26T00:04:34Z \
#   -d headers="{\"hello\":true}" \
#   -d method="post" \
#   -d body="{\"hello\":true}" \
#   -d endpoint="https://random.fr"

# curl \
#   -X POST \
#   -H "Authorization: Bearer CA3knhSEFs8OWzO1_186q7KT-0agve-pUOpzx7UoMzPjiC3Wd-nsIAQcG8vCR-RytaSiToDXNIU_zkLFXBGE1w==" \
#   -H "Content-Type: application/json" \
#   http://localhost:4000/rest/events/ \
#   -d '{"headers":"value1", "key2":"value2"}'



#   [debug] Processing with BloodbathWeb.EventController.create/2
#   Parameters: %{"body" => "{\"hello\":true}", "endpoint" => "https://test.com", "headers" => "{\"hello\":true}", "method" => "post", "scheduled_for" => "2021-05-26T00:04:34Z"}
#   Pipelines: [:rest, :rest_authenticated, :rest_authorized_owner]
