Feature: Specdown::Readme

  The `Specdown::Readme` class accepts a markdown parse tree, and runs the tests found within.

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
  
  We can generate a `Specdown::Readme` instance and run the tests in our markdown by simply passing the filename on instantiation:

      readme = Specdown::Readme.new "specdown.markdown"
      readme.run

  While running, it will emit events during the processing to the Specdown::EventServer. This enables all kinds of functionality, like printing the progress of the tests.

  We can access statistics about the readme execution programatically:
      
      readme.stats.num_tests                   #==> 2
      readme.stats.num_failing                 #==> 1
      readme.stats.num_passing                 #==> 1

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

    When I generate a `Specdown::Readme` instance from it:
      """
        @readme = Specdown::Readme.new "features/fixtures/parser_example.markdown"
      """

    Then I should be able to execute the tests:
      """
        @readme.execute
      """
    
    And I should be able to access the report data programatically:
      """
        @readme.file_name.should == 'parser_example.markdown'
        @readme.stats.num_tests.should == 2
        @readme.stats.num_failing.should == 1
        @readme.stats.num_passing.should == 1
      """
