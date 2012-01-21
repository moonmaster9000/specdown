module Specdown
  class Stats
    attr_accessor :tests, :exceptions, :pending_exceptions
    attr_reader :runner

    def initialize(source_runner=nil)
      @runner = source_runner
      @tests = 0
      @exceptions = []
      @pending_exceptions = []
    end

    def successes
      @tests - failures - pendings
    end

    def failures
      @exceptions.count
    end

    def pendings
      @pending_exceptions.count
    end
  end
end
