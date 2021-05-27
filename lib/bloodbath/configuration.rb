module Bloodbath
  class Configuration
    attr_accessor :api_key
    attr_reader :api_base

    def initialize
      @api_base = 'http://localhost:4000/rest' # 'https://api.bloodbath.io/rest'
    end
  end
end
