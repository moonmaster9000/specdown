module Specdown
  class Stats
    attr_accessor :tests, :exceptions
    attr_reader :runner

    def initialize(source_runner=nil)
      @runner = source_runner
      @tests = 0
      @exceptions = []
    end

    def successes
      @tests - @exceptions.count
    end

    def failures
      @exceptions.count
    end
  end
end
