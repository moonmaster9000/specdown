Feature: Report
  
  Specdown comes with a generic reporting class. If you provide it with a runner (or an array of runners), then it will generate a report for you. 

  
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

  We could then pass it off to our reporter class and receive the following report:

      Specdown::Report.new(runner).generate.should == %{
          1 markdown
          3 tests
          2 successes
          1 failure

          StandardError: error simulation
      %}

  
  Scenario: A Specdown::Report instantiated with a single stats object

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

    Then `Specdown::Report.new(@runner).generate` should include the following output:
      """
        1 markdown
        2 tests
        1 failure

        error simulation
      """
