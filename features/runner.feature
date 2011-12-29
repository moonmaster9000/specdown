Feature: Runner

  The `Specdown::Runner` class accepts a markdown parse tree, and runs the tests found within.

  Imagine we start with this markdown file:

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
  
  We then parse it into a Specdown::Tree:
      
      parse_tree = Specdown::Parser.parse File.read("/path/to/markdown")
  
  We can now generate a new `Specdown::Runner` instance and run the tests:

      runner = Specdown::Runner.new(parse_tree)
      runner.run

  While running, it will print results to STDOUT like "F." 

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
          
          "simple code".should_not == nil

      ### First Leaf

      This section has a failure simulation:
          
          raise "specdown error simulation!"

      ## Last Leaf

      This section is a leaf node. It contains some ruby code:
          
          1.should == 1
      """

    When I parse it into a tree:
      """
        @tree = Specdown::Parser.parse @readme
      """
    
    And I generate a `Specdown::Runner` instance from it:
      """
        @runner = Specdown::Runner.new @tree
      """

    Then I should be able to run the tests:
      """
        @runner.run
      """
    
    And I should be able to access the report data programatically:
      """
      @runner.stats.tests                   #==> 2
      @runner.stats.failures                #==> 1
      @runner.stats.successes               #==> 1
      @runner.stats.exceptions.map(&:to_s)  #==> ['(eval):3:in `execute_test': specdown error simulation!']
      """
