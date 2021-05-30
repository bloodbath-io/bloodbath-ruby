# frozen_string_literal: true
module Bloodbath
  class Configuration
    attr_accessor :api_key, :api_base

    def initialize
      @api_base = "https://api.bloodbath.io/rest"
    end
  end
end
