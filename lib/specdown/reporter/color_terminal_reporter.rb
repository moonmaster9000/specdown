module Specdown
  module ColorTerminalReporter
    def success
      super.green
    end

    def failure
      super.red.bold
    end

    private
    def template
      ERB.new File.read(File.join(File.dirname(__FILE__), "../templates/color_summary.erb"))
    end
  end
end

Specdown::ReporterFactory.decorate do |reporter|
  if Specdown::Config.reporter == :color_terminal
    class ::String
      include ::Term::ANSIColor
    end

    reporter.extend Specdown::TerminalReporter
    reporter.extend Specdown::ColorTerminalReporter
  end

  reporter
end
