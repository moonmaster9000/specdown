module Specdown
  module Reporter
    def summary(readmes)
      ReportSummary.new(readmes)
    end

    def print_start
      raise NotImplementedError
    end

    def print_readme_start(readme)
      raise NotImplementedError
    end

    def print_readme_summary(readme)
      raise NotImplementedError
    end

    def print_readme_end(readme)
      raise NotImplementedError
    end

    def print_test_start(test)
      raise NotImplementedError
    end
    
    def print_test_end(test)
      raise NotImplementedError
    end
    
    def print_summary(readmes)
      raise NotImplementedError
    end

    def print_success(test)
      raise NotImplementedError
    end

    def print_failure(test)
      raise NotImplementedError
    end

    def print_pending(test)
      raise NotImplementedError
    end

    def print_undefined(test)
      raise NotImplementedError
    end

    def print_end
      raise NotImplementedError
    end

    private
    def format_stat(word, number)
      plural_word = word[-2..-1] == "ss" ? "#{word}es" : "#{word}s"
      "#{number} #{number == 1 ? word : plural_word}"
    end
  end
end
