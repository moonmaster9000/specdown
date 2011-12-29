module Specdown
  class Runner
    class Report
      attr_accessor :exceptions, :tests

      def initialize
        @tests = 0
        @exceptions = []
      end

      def failures
        @exceptions.length
      end

      def successes
        @tests - @exceptions.length
      end

      def to_s
        "#{@tests} tests\n"         +
        "#{successes} #{successes == 1 ? "success" : "successes"}\n"  +
        "#{failures} #{failures == 1 ? "failure" : "failures"}\n\n"    +
        @exceptions.map(&:to_s).join("\n")
      end

    end
  end
end
