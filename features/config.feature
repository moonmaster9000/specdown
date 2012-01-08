Feature: Specdown::Config

  You can use a simple Ruby API to configure specdown.

  Note that at any point, you can reset your Specdown::Config to defaults using the `reset!` method:
      
      Specdown::Config.reset!
      Specdown::Config.expectations.should be(nil)

  \## Assertion/Expectation framework

  All of your tests will run within a protected sandbox namespace. If rspec is installed and available, then Specdown will make rspec `should` expectations and matchers availble to your tests. If not, then it will fall back to Test::Unit assertions.

  \### Rspec Expectations

  If you want to explicitly configure `Specdown` to use rspec's expectations, you can use the `expectations` accessor:

      Specdown::Config.expectations = :rspec

  Now, if you instantiate a new sandbox, then rspec's "should" matchers should be available within it:

      Specdown.sandbox.new.instance_eval do
        1.should_not be(nil)
      end

  \### Test::Unit assertions

  If you want to explicitly configure `Specdown` to use Test::Unit assertions, set the `expectations` accessor on `Specdown::Config` to `:test_unit`:

      Specdown::Config.expectations = :test_unit

  Now you'll have access to all of the `assert_*` methods within your tests:

      Specdown.sandbox.new.instance_eval do
        assert_equal 1, 1
      end 

  \### Colorized Terminal Output

  By default, Specdown will colorize your terminal output. If you'd prefer Specdown not to colorize your terminal output, simply set the `reporter` to `:terminal`:

      Specdown.reporter == :terminal

  \## Other reporting formats

  If you prefer that specdown not output your test results to STDOUT, you can choose two other formats: `:text` and `:html`.


  Scenario: Specdown::Config defaults
    * Specdown::Config.expectations #==> nil
    * Specdown::Config.reporter     #==> :color_terminal
    * Specdown::Config.root         #==> "specdown"


  Scenario: Reset the Specdown::Config
    Given I have configured Specdown:
      """
        Specdown::Config.expectations = :rspec
        Specdown::Config.reporter     = :html
        Specdown::Config.root         = "dir/"
      """

    When I reset Specdown:
      """
        Specdown::Config.reset!
      """

    Then my specdown configuration should return to its defaults:
      * Specdown::Config.expectations #==> nil
      * Specdown::Config.reporter     #==> :color_terminal
      * Specdown::Config.root         #==> "specdown"

  Scenario: Default to Rspec expectations

    Given I have rspec installed
    Then Specdown should provide rspec expectations and matchers within the sandbox by default:
      """
        Specdown.sandbox.instance_eval do
          1.should_not be(nil)
        end
      """

  Scenario: Manually configure RSpec expectations
    Given I have manually configured Specdown to use Rspec expectations:
      """
        Specdown::Config.expectations = :rspec
      """

    Then Specdown should provide rspec expectations and matchers within the sandbox:
      """
        Specdown.sandbox.instance_eval do
          1.should_not be(nil)
        end
      """

  Scenario: Manually configure Test::Unit assertions
    Given I have manually configured Specdown to use Test::Unit assertions:
      """
        Specdown::Config.expectations = :test_unit
      """

    Then Specdown should provide Test::Unit assertions within the sandbox:
      """
        Specdown.sandbox.instance_eval do
          assert_equal 1, 1
        end
      """
