module Specdown
  module Reporter
    def summary(runners)
      ReportSummary.new(runners)
    end

    def success
      raise NotImplementedError
    end

    def failure
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
  end
end
