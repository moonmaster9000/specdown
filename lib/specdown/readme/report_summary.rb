module Specdown
  class ReportSummary
    attr_reader :readmes

    def initialize(readmes)
      @readmes = readmes.respond_to?(:map) ? readmes : [readmes]
    end

    def num_markdowns
      @num_markdowns ||= @readmes.count
    end

    def num_tests
      @num_tests ||= @readmes.map(&:stats).map(&:num_tests).inject(0, &:+)
    end

    def num_pending
      @num_pending ||= @readmes.map(&:stats).map(&:num_pending).inject(0, &:+)
    end

    def num_undefined
      @num_undefined ||= @readmes.map(&:stats).map(&:num_undefined).inject(0, &:+)
    end

    def num_failing
      @num_failing ||= @readmes.map(&:stats).map(&:num_failing).inject(0, &:+)
    end

    def num_passing
      @num_passing ||= @readmes.map(&:stats).map(&:num_passing).inject(0, &:+)
    end

    def exceptions
      @exceptions ||= @readmes.map(&:tests).flatten.map(&:exception).compact
    end
  end
end
