module Specdown
  module ReporterFactory
    extend self

    def decorate(&block)
      decorators << block
    end

    def generate
      decorators.inject(Reporter.new) {|reporter, decorator| decorator.call(reporter) }
    end

    private
    def decorators
      @decorators ||= []
    end
  end
end
