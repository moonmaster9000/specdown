module Specdown
  module Reporter
    def summary(runners)
      ReportSummary.new(runners)
    end

    def print_start
      raise NotImplementedError
    end

    def print_runner_start(runner)
      raise NotImplementedError
    end

    def print_runner_summary(runner)
      raise NotImplementedError
    end

    def print_runner_end(runner)
      raise NotImplementedError
    end

    def print_test_start(test)
      raise NotImplementedError
    end
    
    def print_test_end(test)
      raise NotImplementedError
    end
    
    def print_summary(runners)
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
