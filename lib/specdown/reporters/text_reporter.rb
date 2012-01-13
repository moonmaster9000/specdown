module Specdown
  class TextReporter
    include Specdown::Reporter

    def initialize
      @file = File.new "specdown_report.txt", "w"
    end

    def print_start
      @file.write Time.now.to_s
      @file.write "\n\n"
    end

    def print_runner_start(runner)
      @file.write(runner.file_name + ": ")
    end

    def print_runner_end(runner)
      @file.write "\n\n" 
    end

    def print_success(test) 
      @file.write "."
    end

    def print_failure(test)
      @file.write "F"
    end

    def print_end
      @file.close
    end

    def print_summary(runners)
      @report_summary = summary(runners)
      bounding = binding rescue proc {}
      @file.write template.result(bounding)
    end
    
    private
    def template
      ERB.new File.read(File.join(File.dirname(__FILE__), "../templates/summary.erb"))
    end
  end
end
