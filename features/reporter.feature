Feature: Reporter
  
  Specdown comes with a generic reporting class. By itself, the Specdown::Reporter does little (most methods throw a `NotImplementedError` exception). However, the `Specdown::ReporterFactory` will generate an instance of this class, then decorate based on your configuration.
  
  For example, suppose we have the following markdown file:
      
      \# Specdown Example

      This is an example specdown file.

      \## Child Node

      This section is a child node. It contains some ruby code: 
          
          "simple code".should_not == nil

      \### First Leaf

      This section has a failure simulation:
          
          raise "specdown error simulation!"

      \## Last Leaf

      This section is a leaf node. It contains some ruby code:
          
          1.should == 1
  
  If we create a Specdown::Runner instance from it and run it:

      runner = Specdown::Runner.new("/features/fixtures/parser_example.markdown")
      runner.run

  We could then retrieve a report summary like so:

      Specdown::Reporter.new.summary(runner).class.should == Specdown::ReportSummary

  The generic reporter doesn't actually print anything:
      
      proc { Specdown::Reporter.new.print_summary(runner) }.should raise_exception(NotImplementedError)
      proc { Specdown::Reporter.new.print_success(test)   }.should raise_exception(NotImplementedError)
      proc { Specdown::Reporter.new.print_failure(test)   }.should raise_exception(NotImplementedError)

  Scenario: A Specdown::Reporter instantiated with a single stats object

    Given the following specdown example file located at 'features/fixtures/parser_example.markdown':
      """
      # Specdown Example

      This is an example specdown file.

      ## Child Node

      This section is a child node. It contains some ruby code: 
          
          "simple code".should_not == nil

      ### First Leaf

      This section has a failure simulation:
          
          raise "specdown error simulation!"

      ## Last Leaf

      This section is a leaf node. It contains some ruby code:
          
          1.should == 1
      """
    
    And the following runner:
      """
        @runner = Specdown::Runner.new("features/fixtures/parser_example.markdown")
      """

    When I run the tests in the runner:
      """
        @runner.run
      """

    Then `Specdown::Reporter.new.summary(@runner)` should return a report summary object:
      """
        @reporter = Specdown::Reporter.new
        @reporter.summary(@runner).class.should == Specdown::ReportSummary
      """

    And the generic reporter shouldn't actually print anything:
      """
        proc { @reporter.print_summary(nil) }.should raise_exception(NotImplementedError)
        proc { @reporter.print_success(nil) }.should raise_exception(NotImplementedError)
        proc { @reporter.print_failure(nil) }.should raise_exception(NotImplementedError)
      """
