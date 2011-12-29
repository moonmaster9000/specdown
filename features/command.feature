Feature: `specdown` command

  Specdown comes with a `specdown` command that allows you to run your tests from the command line.

  By default, running `specdown` at a command prompt will cause specdown to look in the current working directory for a "specdown" directory. If it finds a directory called `specdown`, it will eval all code files it finds, then load all "markdown" files and run them, providing you with a report at the end.

  Scenario: `specdown` with no arguments, and no specdown directory

    When I run `specdown` from the command line in a directory that contains no 'specdown' directory
    Then I should see the following output:
      """
        0 markdowns
        0 tests
        0 failures
      """

  Scenario: `specdown` with no arguments, and a specdown directory with a single test
    
    Given I have a specdown directory containing a single markdown file:
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

    When I run `specdown` with no arguments
    Then I should see the following output:
      """
        1 markdown
        2 tests
        2 failures

        undefined method `should_not' for "simple code":String
        undefined method `should' for 1:Fixnum
      """

  Scenario: `specdown` with no arguments, and a specdown directory containing a single ruby file and a single markdown file
    Given I have a specdown directory containing a markdown file:
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
    And a single ruby file:
      """
      require 'rubygems'
      require 'rspec/expectations'
      """
    When I run `specdown` with no arguments
    Then I should see the following output:
      """
        1 markdown
        2 tests
        1 failure

        specdown error simulation!
     """
