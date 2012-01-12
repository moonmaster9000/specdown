module Specdown
  class TerminalReporter
    include Specdown::Reporter

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
      bounding = binding rescue proc {}
      template.run bounding
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
