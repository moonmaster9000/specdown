Feature: Specdown::ReporterFactory

  The `Specdown::ReporterFactory` will generate a `Specdown::Reporter` instance, then decorate it in various ways depending on your specdown configuration.

  The `Specdown::ReporterFactory` has an API that allows you to configure new decorators for reports. Use the `Specdown::ReporterFactory.decorate` method:

      Specdown::ReporterFactory.decorate do |report|
        if Specdown::Config.reporter == :color_terminal
          report.extend MyDecoratorModule
        end
      end

  For example, if you configure specdown to output colorized terminal output (the default value for Specdown::Config.reporter, :color_terminal), then `Specdown::ReporterFactory` will mix the `Specdown::AnsiColor` decorator into your `Specdown::Reporter` instance.

      Specdown::Config.reporter = :color_terminal
      Specdown::ReporterFactory.generate.ancestors.should include(Specdown::AnsiColor)


  Scenario: Adding a new decorator to Specdown::ReporterFactory
    
    Given I have added the following decorator to `Specdown::ReporterFactory`:
      """
        Specdown::ReporterFactory.decorate do |reporter|
          module FactoryTester
          end

          reporter.extend FactoryTester

          reporter
        end
      """

    Then reporters should be decorated with my new decorator:
      """
        Specdown::ReporterFactory.generate.kind_of?(FactoryTester).should be(true)
      """


  Scenario: Specdown::Config.reporter = :terminal

    Given that I want a non-colorized text output report:
      """
        Specdown::Config.reporter = :terminal
      """

    Then `Specdown::ReporterFactory.generate` should return a `Specdown::Reporter` decorated with `Specdown::TerminalReporter`:
      """
        Specdown::ReporterFactory.generate.kind_of?(Specdown::TerminalReporter).should be(true)
      """


  Scenario: Specdown::Config.reporter = :color_terminal
    
    Given that I want a colorized Specdown::Reporter:
      """
        Specdown::Config.reporter = :color_terminal
      """

    Then `Specdown::ReporterFactory.generate` should return a `Specdown::Reporter` decorated with `Specdown::TerminalReporter` and `Specdown::ColorTerminalReporter`:
      """
        Specdown::ReporterFactory.generate.kind_of?(Specdown::TerminalReporter).should be(true)
        Specdown::ReporterFactory.generate.kind_of?(Specdown::ColorTerminalReporter).should be(true)
      """
