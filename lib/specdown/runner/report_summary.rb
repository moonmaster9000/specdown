module Specdown
  class ReportSummary
    attr_reader :runners

    def initialize(runners)
      @runners = runners.respond_to?(:map) ? runners : [runners]
    end

    def num_markdowns
      @num_markdowns ||= @runners.count
    end

    def num_tests
      @num_tests ||= @runners.map(&:stats).map(&:tests).inject(0, &:+)
    end

    def num_failures
      @num_failures ||= @runners.map(&:stats).map(&:failures).inject(0, &:+)
    end

    def num_successes
      @num_successes ||= @runners.map(&:stats).map(&:successes).inject(0, &:+)
    end

    def exceptions
      @exceptions ||= @runners.map(&:stats).map(&:exceptions).flatten
    end
  end
end
