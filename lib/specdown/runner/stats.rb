module Specdown
  class Stats
    attr_accessor :tests, :exceptions

    def initialize
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
