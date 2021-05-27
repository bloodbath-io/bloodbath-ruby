require 'net/http'
require 'pry'
require 'json'

module Bloodbath::Adapters
  class Rest
    attr_reader :method, :endpoint, :body, :config

    def initialize(method:, endpoint:, body: nil, config: Bloodbath.config)
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
      serialized_response_from response.body
    end

    def serialized_response_from(body)
      return {} if body.nil?
      JSON.parse(body, symbolize_names: true)
    rescue JSON::ParserError
      {}
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
        adapter.new(method: :post, endpoint: '/events', body: args).perform
      end

      def list
        adapter.new(method: :get, endpoint: '/events').perform
      end

      def find(id)
        adapter.new(method: :get, endpoint: "/events/#{id}").perform
      end

      def cancel(id)
        adapter.new(method: :delete, endpoint: "/events/#{id}").perform
      end

      private

      def adapter
        Bloodbath::Adapters::Rest
      end
    end
  end
end