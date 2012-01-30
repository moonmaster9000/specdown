Feature: `specdown` command

  Specdown comes with a `specdown` command that allows you to run your tests from the command line.

  By default, running `specdown` at a command prompt will cause specdown to look in the current working directory for a "specdown" directory. If it finds a directory called `specdown`, it will eval all code files it finds, then load all "markdown" files and run them, providing you with a report at the end.

  @focus
  Scenario: `specdown` exits with status "0" if all tests pass
    When I run `specdown` from the command line for a passing readme
    Then it should exit with status 0
    When I run `specdown` from the command line for a pending readme
    Then it should not exit with status 0
    When I run `specdown` from the command line for a failing readme
    Then it should not exit with status 0
    When I run `specdown` from the command line for a undefined readme
    Then it should not exit with status 0

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

    When I run `specdown` with no arguments
    Then I should see the following output:
      """
        F.

        1 markdown
        2 tests
        1 failure

        specdown error simulation
      """

  Scenario: `specdown` with no arguments, and a specdown directory containing a single ruby file and a single markdown file
    Given I have a specdown directory containing a markdown file:
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
    And a single ruby file:
      """
        Specdown::Config.expectations = :test_unit
      """
    When I run `specdown` with no arguments
    Then I should see the following output:
      """
        FF

        1 markdown
        2 tests
        2 failures

        In parser_example.markdown: <#NoMethodError> undefined method `be'
        In parser_example.markdown: <#NoMethodError> undefined method `satisfy'
     """


  Scenario: `specdown` command invoked with a directory
    Given I have a specdown directory 'specdown/tests' containing 3 markdown files, each with 1 passing test
    When I run `specdown specdown/tests`
    Then I should see the following output:
      """
        1.markdown: .
        2.markdown: .
        3.markdown: .

        3 markdowns
        3 tests
        0 failures
      """

  Scenario: colorized output switches
    * The following commands should yield colorized output:
      * `specdown -c`
      * `specdown --colorized`

  Scenario: plain output (non-colorized) switches
    * The following commands should yield non-colorized output:
      * `specdown -n`
      * `specdown --non-colorized`

  Scenario: text output
    * The following commands should output reports to a text file, 'specdown_report.txt':
      * `specdown -o text`
      * `specdown --output=text`

  Scenario: terminal output
    * The following commands should output reports to STDOUT:
      * `specdown -o terminal`
      * `specdown --output=terminal`

  Scenario: short summary output
    * The following commands should output only the most basic summary information to STDOUT:
      * `specdown -f short`
      * `specdown --format=short`

  Scenario: short summary output
    * The following commands should output summary information for each file run to STDOUT:
      * `specdown -f condensed`
      * `specdown --format=condensed`
