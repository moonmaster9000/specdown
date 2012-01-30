module Specdown
  class Stats
    attr_reader :readme

    def initialize(readme=nil)
      @readme = readme
    end

    def num_tests
      @readme.tests.count
    end

    def num_passing
      @readme.tests.select {|test| test.status == :passing}.count
    end

    def num_failing
      @readme.tests.select {|test| test.status == :failing}.count
    end

    def num_pending
      @readme.tests.select {|test| test.status == :pending}.count
    end

    def num_undefined
      @readme.tests.select {|test| test.status == :undefined}.count
    end
  end
end
