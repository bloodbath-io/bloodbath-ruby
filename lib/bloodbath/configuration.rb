module Bloodbath
  class Configuration
    attr_accessor :api_key
    attr_reader :api_base

    def self.setup
      new.tap do |instance|
        yield(instance) if block_given?
      end
    end

    def initialize
      @api_base = 'https://api.bloodbath.io'
    end
  end
end
