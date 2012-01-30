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

    def print_readme_start(readme)
      @file.write(readme.file_name + ": ")
    end

    def print_readme_end(readme)
      @file.write "\n\n" 
    end

    def print_success(test) 
      @file.write "."
    end

    def print_failure(test)
      @file.write "F"
    end

    def print_pending(test)
      @file.write "P"
    end

    def print_undefined(test)
      @file.write "U"
    end

    def print_end
      @file.close
    end

    def print_summary(readmes)
      @report_summary = summary(readmes)
      bounding = binding rescue proc {}
      @file.write template.result(bounding)
    end
    
    private
    def template
      ERB.new File.read(File.join(File.dirname(__FILE__), "../templates/summary.erb"))
    end
  end
end
