Feature: Runner

  The `Specdown::Runner` class accepts a markdown parse tree, and runs the tests found within.

  Imagine we start with this markdown file (saved at "specdown.markdown"):

      \# Specdown Example

      This is an example specdown file.

      \## Child Node

      This section is a child node. It contains some ruby code: 
          
      ```ruby
      "simple code".should_not be(nil)
      ```

      \### First Leaf

      This section has a failure simulation:
          
      ```ruby
      raise "specdown error simulation!"
      ```

      \## Last Leaf

      This section is a leaf node. It contains some ruby code:

      ```ruby
      1.should satisfy(&:odd?)
      ```
  
  We can generate a `Specdown::Runner` instance and run the tests in our markdown by simply passing the filename on instantiation:

      runner = Specdown::Runner.new "specdown.markdown"
      runner.run

  While running, it will emit events during the processing to the Specdown::EventServer. This enables all kinds of functionality, like printing the progress of the tests.

  We can access statistics about the run programatically:
      
      runner.stats.tests                   #==> 2
      runner.stats.failures                #==> 1
      runner.stats.successes               #==> 1
      runner.stats.exceptions.map(&:to_s)  #==> ['StandardError: "specdown error simulation"']

  Scenario: Running tests

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

    When I generate a `Specdown::Runner` instance from it:
      """
        @runner = Specdown::Runner.new "features/fixtures/parser_example.markdown"
      """

    Then I should be able to run the tests:
      """
        @runner.run
      """
    
    And I should be able to access the report data programatically:
      """
      @runner.file_name.should == 'parser_example.markdown'
      @runner.stats.tests.should == 2
      @runner.stats.failures.should == 1
      @runner.stats.successes.should == 1
      @runner.stats.exceptions.map(&:exception_message).should == ["specdown error simulation!"]
      """
