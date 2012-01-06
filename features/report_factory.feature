Feature: Specdown::ReportFactory

  The `Specdown::ReportFactory` will generate a `Specdown::Report` instance, then decorate it in various ways depending on your specdown configuration.

  For example, if you configure specdown to output colorized terminal output, then `Specdown::ReportFactory` will mix the `Specdown::AnsiColor` decorator into your `Specdown::Report` instance.

      Specdown.colorize = true
      Specdown::ReportFactory.generate.ancestors.should include(Specdown::AnsiColor)

  If you configure specdown to output an HTML report, then Specdown::ReportFactory will mix the `Specdown::HtmlReport` decorator into your `Specdown::Report` instance.

      Specdown.report_format = :html
      Specdown::ReportFactory.generate.ancestors.should include(Specdown::HtmlReport)


  Scenario: Specdown.colorize = false, Specdown.report_format = :text

    Given that I want a non-colorized text output report:
      """
        Specdown.colorize = false
      """

    Then `Specdown::ReportFactory.generate` should return a non-decorated `Specdown::Report`:
      """
        [Specdown::AnsiColor, Specdown::HtmlReport].each do |decorator|
          Specdown::ReportFactory.ancestors.should_not include(decorator)
        end
      """


  Scenario: Specdown.colorize = true
    
    Given that I want a colorized Specdown::Report:
      """
        Specdown.colorize = true
      """

    Then `Specdown::ReportFactory.generate` should return a `Specdown::Report` decorated with `Specdown::AnsiColor`
      """
        Specdown::ReportFactory.generate.ancestors.should include(Specdown::AnsiColor)
      """


  Scenario: Specdown.report_format = :html

    Given that I want an html report:
      """
        Specdown.report_format = :html
      """

    Then `Specdown::ReportFactory.generate` should return a `Specdown::Report` decorated with `Specdown::HtmlReport`
      """
        Specdown::ReportFactory.generate.ancestors.should include(Specdown::HtmlReport)
      """
