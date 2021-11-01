# frozen_string_literal: true
require "net/http"
require "pry"
require "json"

module Bloodbath
  module Adapters
    class Rest
      @@threads = []
      @@count = 0

      attr_reader :method, :endpoint, :body, :options, :config

      at_exit do
        # TODO: abstract into a method or something
        @@threads.each(&:join).tap do
          @@threads = []
        end
      end

      def initialize(method:, endpoint:, body: nil, options:, config: Bloodbath.config)
        @method = method
        @endpoint = endpoint
        @body = body
        @options = options
        @config = config
      end

      def perform
        check_api_key

        if options[:wait_for_response]
          synchronous_call_with_response
        else
          asynchronously { synchronous_call_with_response }
        end
      end


      private

      def check_api_key
        raise Bloodbath::Error, "Please set your API key through Bloodbath.api_key = 'my-api-key'" unless config.api_key
      end

      def asynchronously
        # TODO: refactor this to be more readable
        @@threads << Thread.new { synchronous_call_with_response }

        if @@threads.size >= 10
          @@count += 10
          @@threads.each(&:join).tap do
            @@threads = []
          end
        end
      end

      def synchronous_call_with_response
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true if uri.instance_of?(URI::HTTPS)

        request["Authorization"] = "Bearer #{config.api_key}"
        request["Content-Type"] = "application/json"
        request.body = body.to_json

        response = http.request(request)
        serialized_response_from(response.body)
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
end

# when we want to add specific Ruby library options we instanciate what we want
# instead of going with Event.schedule we do Event.new(my_option: true).schedule
# this is to manage the transition to go class first while adding the options
module Bloodbath
  class Event
    class << self
      def method_missing(method, args, &block)
        self.new(arguments).send(method, *arguments, &block)
      end
    end

    attr_reader :options

    def initialize(wait_for_response: true)
      @options = {
        wait_for_response: wait_for_response
      }
    end

    def schedule(args)
      adapter.new(method: :post, endpoint: "/events", body: args, options: options).perform
    end

    def list
      adapter.new(method: :get, endpoint: "/events", options: options).perform
    end

    def find(id)
      adapter.new(method: :get, endpoint: "/events/#{id}", options: options).perform
    end

    def cancel(id)
      adapter.new(method: :delete, endpoint: "/events/#{id}", options: options).perform
    end

    private

    def adapter
      Bloodbath::Adapters::Rest
    end
  end
end
