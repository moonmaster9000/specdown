module Specdown
  module TerminalReporter
    def success
      "."
    end

    def failure
      "F"
    end

    def print_success(test)
      print success
    end

    def print_failure(test)
      print failure
    end

    def print_summary(runners)
      @report_summary = summary(runners)
      template.run(proc {})
    end
    
    private
    def template
      ERB.new File.read(File.join(File.dirname(__FILE__), "../templates/summary.erb"))
    end

    def format_stat(word, number)
      plural_word = word[-2..-1] == "ss" ? "#{word}es" : "#{word}s"
      "#{number} #{number == 1 ? word : plural_word}"
    end
  end
end

Specdown::ReporterFactory.decorate do |reporter|
  if Specdown::Config.reporter == :terminal
    reporter.extend Specdown::TerminalReporter
  end
  reporter
end
