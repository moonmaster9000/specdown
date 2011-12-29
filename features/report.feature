Feature: Report
  
  Specdown comes with a generic reporting class. If you provide it with a runner's Specdown::Stats object (or an array of Specdown::Stats objects), then it will generate a report for you. 

  For example, suppose we have the following Specdown::Stats instance:

      stats = Specdown::Stats.new
      stats.tests = 3
      stats.exceptions = [StandardError.new("error simulation")]

  We could then pass it off to our reporter class and receive the following report:

      Specdown::Report.new(stats).generate.should == %{
          1 markdown
          3 tests
          2 successes
          1 failure

          StandardError: error simulation
      %}

  
  Scenario: A Specdown::Report instantiated with a single stats object
    
    Given the following Specdown::Stats instance:
      """
        @stats        = Specdown::Stats.new
        @stats.tests  = 3
        @stats.exceptions << StandardError.new("error simulation")
      """

    Then `Specdown::Report.new(@stats).generate` should include the following output:
      """
        1 markdown
        3 tests
        1 failure

        error simulation
      """

  Scenario: A Specdown::Report instantiated with an array of stats

    Given the following of Specdown::Stats instances:
      """
        @results = [
          Specdown::Stats.new.tap {|s| s.tests = 3 },
          Specdown::Stats.new.tap {|s| s.tests = 1; s.exceptions << StandardError.new("error simulation") }
        ]
      """
    
    Then `Specdown::Report.new(@results).generate` should include the following output:
      """
        2 markdowns
        4 tests
        1 failure

        error simulation
      """
