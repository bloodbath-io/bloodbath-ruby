# frozen_string_literal: true

module Bloodbath
  class Configuration
    attr_accessor :api_key, :api_base, :verbose

    def initialize
      @api_base = "https://api.bloodbath.io/rest" # "http://localhost:4000/rest"
      @verbose = false
    end
  end
end
