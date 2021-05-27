# frozen_string_literal: true
require 'forwardable'

require_relative "bloodbath/version"
require_relative "bloodbath/configuration"
require_relative "bloodbath/event"

module Bloodbath
  class Error < StandardError; end
  @config = Bloodbath::Configuration.new

  class << self
    extend Forwardable

    attr_reader :config
    def_delegators :@config, :api_key, :api_key=
    def_delegators :@config, :api_base, :api_base=
  end
end
