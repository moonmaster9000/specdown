module Specdown
  class Report
    def initialize(runners)
      runners = [runners] unless runners.respond_to?(:map)
      @stats = runners.map &:stats
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
      formatted_exceptions = []
      @stats.each do |stat|
        formatted_exceptions << stat.exceptions.map do |e| 
          [
            (stat.runner ? "In #{stat.runner.file_name}: " : "") + "<#{e.class}> #{e}", 
            e.backtrace
          ].join "\n"
        end
      end
      formatted_exceptions.flatten
    end
  end
end
