Feature: Specdown::Test

  A `Specdown::Test` is constructed by specdown for every path from the root of a markdown file to a leaf section.

  For example, consider the following markdown file:

      \# The Calculator Gem

      ...

      \## A calculation object

      ...

      \### Basic Usage

      ...

      \## Static Operations

      ...
      
      \### Saving Results

      ...
  
  The headings in this markdown naturally form a tree:


                      The Calculator Gem
                           /     \
                          /       \
          A calculation object   Static Operations
                        /           \ 
                       /             \
          Static Operations      Saving Results


  Specdown will construct a `Specdown::Test` object for each path from the root ("The Calculator Gem") to a leaf, gathering any code (whether explicit or implicit) along the way:
  
  * The Calculator Gem -> A calculation object -> Static Operations
  * The Calculator Gem -> Static Operations    -> Saving Results

  It will also tell the test about any undefined implicits it finds within the markdown.

  You can add code to a test via the "code" array accessor:

      test      = Specdown::Test.new
      test.code << "puts 'hi'"
      test.code << "howdy"

  If your markdown contains any undefined implicit specifications, you can add them to a `Specdown::Test` instance via the "undefined_implicits" method:

      test.undefined_implicits << "I am an implicit specification that is not yet defined!"

  You can execute the test via the "execute" method:

      test.execute

  After the test executes, you can get the status of the test via the `status` method. It will return one of the following symbols: `:passing`, `:failing`, `:pending`, `:undefined`.

  If a test throws an exception, that exception will be captured and made accessible via the `exception` method.

  You can add callbacks to tests via the "hook_before(:execute)", "hook_after(:execute)", and "hook_around(:execute)" methods:

      Specdown::Test.hook_after(:execute) do |test|
        case test.status
          when :passing   then Specdown.reporter.print_success(test)
          when :failing   then Specdown.reporter.print_failure(test)
          when :pending   then Specdown.reporter.print_pending(test)
          when :undefined then Specdown.reporter.print_undefined(test)
        end
      end


  Scenario: Reset callbacks
    * You can remove all `Specdown::Test` callbacks by calling `Specdown::Test.remove_callbacks!`

  Scenario: Add code
    Given a `Specdown::Test` instance:
      """
        @test = Specdown::Test.new
      """

    Then I should be able to add code to it:
      """
        @test.code << "1"
        @test.code << "2"
      """


  Scenario: Add undefined implicits
    Given a `Specdown::Test` instance `@test`
    Then I should be able to add undefined implicits to it:
      """
        @test.undefined_implicits << "implicit 1"
        @test.undefined_implicits << "implicit 2"
      """

  Scenario: Status after test execution
    Given a `Specdown::Test` instance `@test`
    When I execute it, the test status should be:
      * :passing   if it doesn't throw any exceptions and has no undefined implicits
      * :undefined if it has any undefined implicits
      * :pending   if it throws a `Specdown::Pending` exception
      * :failing   if it throws an exception other than `Specdown::Pending` 

  Scenario: Capturing exceptions  
    * If your test throws an exception, you can access it via the `exception` method

  Scenario: Hooks
    * The `Specdown::Test.hook_before(:execute)` method allows you to add code that runs before every test:
      """
        Specdown::Test.before do |test|
          puts "I run before every test!"
        end
      """

    * The `Specdown::Test.hook_after(:execute)` method allows you to add code that runs after every test:
      """
        Specdown::Test.after do |test|
          puts "I run after every test!"
        end
      """

    * The `Specdown::Test.hook_around(:execute)` method allows you to add code that runs around every test:
      """
        Specdown::Test.around do |test|
          puts "I run around every test!"
        end
      """
