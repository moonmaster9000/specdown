module Specdown
  class TerminalReporter
    include Specdown::Reporter

    def success
      "."
    end

    def failure
      "F"
    end

    def pending
      "P"
    end

    def print_start
    end

    def print_end
    end

    def print_runner_start(runner)
      print "#{runner.file_name}: "
    end

    def print_runner_summary(runner)
    end

    def print_runner_end(runner)
      print "\n"
    end

    def print_test_start(test)
    end
    
    def print_test_end(test)
    end

    def print_success(test)
      print success
    end

    def print_pending(test)
      print pending
    end

    def print_failure(test)
      print failure
    end

    def print_summary(runners)
      @report_summary = summary(runners)
      bounding = binding rescue proc {}
      template.run bounding
    end
    
    private
    def template
      ERB.new File.read(File.join(File.dirname(__FILE__), "../templates/summary.erb"))
    end
  end
end
