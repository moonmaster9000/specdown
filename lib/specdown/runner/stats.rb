module Specdown
  class Stats
    attr_accessor :tests, :exceptions, :pending_exceptions, :undefined_implicits, :undefined_tests
    attr_reader :runner

    def initialize(source_runner=nil)
      @runner = source_runner
      @tests = 0
      @exceptions = []
      @pending_exceptions = []
      @undefined_implicits = []
      @undefined_tests = 0
    end

    def successes
      @tests - failures - pendings - undefined_tests
    end

    def failures
      @exceptions.count
    end

    def pendings
      @pending_exceptions.count
    end

    def undefined
      @undefined_implicits.count
    end
  end
end
