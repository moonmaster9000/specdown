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

    def undefined
      "U"
    end

    def print_start
    end

    def print_end
    end

    def print_readme_start(readme)
      print "#{readme.file_name}: "
    end

    def print_readme_summary(readme)
    end

    def print_readme_end(readme)
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

    def print_undefined(test)
      print undefined
    end

    def print_summary(readmes)
      @report_summary = summary(readmes)
      bounding = binding rescue proc {}
      template.run bounding
    end
    
    private
    def template
      ERB.new File.read(File.join(File.dirname(__FILE__), "../templates/summary.erb"))
    end
  end
end
