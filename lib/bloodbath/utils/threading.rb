# frozen_string_literal: true

module Bloodbath
  module Utils
    module Threading
      MAX_ACTIVE_THREADS = 10
      @@threads = []
      @@count = 0

      class << self
        def join_all_threads
          @@threads.each(&:join).tap do
            @@count += @@threads.size
            @@threads = []
          end.map(&:value)
        end
      end

      at_exit do
        Bloodbath::Utils::Verbose.capture("result of threads (exit mode)") do
          Utils::Threading.join_all_threads
        end
      end

      def threading
        Thread.new { yield }.tap do |thread|
          to_active_threads(thread)

          if active_threads.size >= MAX_ACTIVE_THREADS
            Bloodbath::Utils::Verbose.capture("result of threads (reached limit)") do
              Utils::Threading.join_all_threads
            end
          end
        end
      end

      private

      def to_active_threads(thread)
        @@threads << thread
      end

      def active_threads
        @@threads
      end
    end
  end
end
