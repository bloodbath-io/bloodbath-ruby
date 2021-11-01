module Bloodbath
  module Utils
    module Threading
      MAX_ACTIVE_THREADS = 10.freeze
      @@threads = []
      @@count = 0

      class << self
        def join_all_threads
          @@threads.each(&:join).tap do
            @@count += @@threads.size
            @@threads = []
          end
        end
      end

      at_exit do
        join_all_threads
      end

      def threading(&block)
        thread = Thread.new { yield }
        to_active_threads(thread)

        Utils::Threading.join_all_threads if active_threads.size >= MAX_ACTIVE_THREADS
        thread
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
