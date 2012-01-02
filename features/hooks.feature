Feature: Specdown test hooks

  You can create test hooks that run before, after, and around tests. You can create global hooks, or hooks that run only for specific specdown files.
  
  \## Global hooks

  To create a global before hook, use the `Specdown.before` method:

      Specdown.before do
        puts "I run before every single test!"
      end

  That before hook will - you guessed it - RUN BEFORE EVERY SINGLE TEST.

  Similary, you can run some code after every single test via the `Specdown.after` method:

      Specdown.after do
        puts "I run after every single test!"
      end

  Whenever you need some code to run before _and_ after every single test, use the `Specdown.around` method:

      Specdown.around do
        puts "I run before _AND_ after every single test!"
      end

  \### Scoping your hooks to specific markdown files

  You might, at times, want hooks to run only for certain files. 

  You can pass filenames (or regular expressions) to the `Specdown.before`, `Specdown.after`, and `Specdown.around` methods. The hooks will then execute whenever you execute any markdown file with matching filenames.

      Specdown.before "somefile.markdown", /^.*\.database.markdown$/ do
        puts "This runs before every test within 'somefile.markdown', and
              before every test in any markdown file whose filename ends 
              with '.database.markdown'"
      end

  Scenario: Before hook

    Given a specdown directory with a markdown file with TWO tests
    And an environment file with the following before hook:
      """
        Specdown.before do
          puts "I run before every test!"
        end
      """
    
    When I run the specdown command for that directory

    Then I should see the following output 2 times:
      """
        I run before every test!
      """


  Scenario: After hook

    Given a specdown directory with a markdown file with THREE tests
    And an environment file with the following after hook:
      """
        Specdown.after do
          puts "I run after every test!"
        end
      """

    When I run the specdown command for that directory

    Then I should see the following output 3 times:
      """
        I run after every test!
      """


  Scenario: Around hook

    Given a specdown directory with a markdown file with ONE test
    And an environment file with the following around hook:
      """
        Specdown.around do
          puts "I run before and after every test!"
        end
      """

    When I run the specdown command for that directory

    Then I should see the following output 2 times:
      """
        I run before and after every test!
      """

  @focus
  Scenario: Scoped hooks
    Given a specdown directory containing markdown files named "spec1.fun.markdown", "spec2.fun.markdown", and "spec3.markdown" each containing a single test
    And an environment file with the following hooks:
      """
        Specdown.around /fun/ do
          puts "I run before and after fun tests."
        end

        Specdown.before "spec3.markdown" do
          puts "I run before tests in spec3"
        end

        Specdown.after "spec1.markdown", /spec3/ do
          puts "I run after tests in spec1 and spec3."
        end
      """

    When I run the specdown command for that directory

    Then I should see the following output 4 times:
      """
        I run before and after fun tests.
      """

    And I should see the following output 1 time:
      """
        I run before tests in spec3
      """

    And I should see the following output 2 times:
      """
        I run after tests in spec1 and spec3
      """
