Feature: Specdown::ReportSummary
  
  A `Specdown::ReportSummary` will provide you with aggregate statistical information about your readmes.

  For example, suppose you have several readmes that you've executed. You could pass one or more of them off to a `Specdown::ReportSummary` to obtain the aggregate totals:

      summary = Specdown::ReportSummary.new(readmes)
      summary.num_markdowns
      summary.num_tests
      summary.num_failing
      summary.num_passing
  
  Scenario: A Specdown::Reporter instantiated with a single stats object

    Given the following specdown example file:
      """
      # Specdown Example

      This is an example specdown file.

      ## Child Node

      This section is a child node. It contains some ruby code: 
          
      ```ruby
      "simple code".should_not be(nil)
      ```

      ### First Leaf

      This section has a failure simulation:
          
      ```ruby
      raise "specdown error simulation!"
      ```

      ## Last Leaf

      This section is a leaf node. It contains some ruby code:

      ```ruby
      1.should satisfy(&:odd?)
      ```
      """
    
    And the following readme:
      """
        @readme = Specdown::Readme.new("features/fixtures/parser_example.markdown")
      """

    When I run the tests in the readme:
      """
        @readme.execute
      """

    Then `Specdown::ReportSummary.new(@readme)` should give me aggregate statistics about my readme execution:
      """
        summary = Specdown::ReportSummary.new(@readme)
        summary.num_markdowns.should == 1
        summary.num_tests.should == 2
        summary.num_failing.should == 1
        summary.num_passing.should == 1
        summary.exceptions.count.should == 1
        summary.exceptions.first.test_filename.should == "parser_example.markdown"
        summary.exceptions.first.exception_class.should == RuntimeError
        summary.exceptions.first.exception_message.should include("specdown error simulation!")
      """
