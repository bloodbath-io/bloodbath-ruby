# frozen_string_literal: true

module Bloodbath
  module Utils
    class Verbose
      class << self
        COLORS = {
          red: 31,
          green: 32,
          blue: 34
        }.freeze

        def capture(label)
          result = yield
          if verbose?
            puts "
            #{screen("[VERBOSE]")} #{screen("#{label}:", color: :blue)} #{screen(result, color: :red)}
            "
          end
        end

        private

        def verbose?
          Bloodbath.config.verbose
        end

        def screen(message, color: :green)
          "\e[#{COLORS[color]}m#{message}\e[0m"
        end
      end
    end
  end
end
