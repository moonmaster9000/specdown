module Specdown
  class Report
    def initialize(stats)
      if stats.kind_of? Array
        @stats = stats
      else
        @stats = [stats]
      end
    end
    
    def generate
      [
        format_stat("markdown", markdowns), 
        format_stat("test", tests), 
        format_stat("failure", failures)
      ].join("\n") + "\n\n" + exceptions.join("\n\n")
    end
    
    private
    def format_stat(word, number)
      "#{number} #{number == 1 ? word : word + "s"}"
    end

    def tests
      @tests ||= @stats.inject(0) {|sum, stat| sum += stat.tests}
    end

    def failures
      @failures ||= @stats.inject(0) {|sum, stat| sum += stat.failures}
    end

    def markdowns
      @stats.count
    end
   
    def exceptions
      @stats.collect(&:exceptions).flatten.map {|e| [e.to_s, e.backtrace].join "\n"}
    end
  end
end
