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
      report_summary = summary(runners)

      puts [
        format_stat("markdown", report_summary.num_markdowns), 
        format_stat("test", report_summary.num_tests), 
        format_stat("failure", report_summary.num_failures)
      ].join("\n") + "\n\n" + exceptions(runners).join("\n\n")
    end
    
    private
    def format_stat(word, number)
      "#{number} #{number == 1 ? word : word + "s"}"
    end
   
    def exceptions(runners)
      formatted_exceptions = []
      runners.map(&:stats).each do |stat|
        formatted_exceptions << stat.exceptions.map do |e| 
          [
            "In #{e.test_filename}: <#{e.exception_class}> #{e.exception_message}", 
            e.exception_backtrace
          ].join "\n"
        end
      end
      formatted_exceptions.flatten
    end
  end
end

Specdown::ReporterFactory.decorate do |reporter|
  if Specdown::Config.reporter == :terminal
    reporter.extend Specdown::TerminalReporter
  end
  reporter
end
