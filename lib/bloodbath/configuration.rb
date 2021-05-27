module Bloodbath
  class Configuration
    attr_accessor :api_key
    attr_accessor :api_base

    def initialize
      @api_base = 'https://api.bloodbath.io/rest'
    end
  end
end
