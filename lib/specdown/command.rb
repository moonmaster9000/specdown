module Specdown
  class Command
    def initialize
      @markdowns = Dir["specdown/**/*.markdown"]
    end

    def execute
      run
      report
    end
    
    private
    def run
      @results =
        @markdowns.map {|markdown| 
          Parser.parse(File.read(markdown))
        }.map {|tree| 
          Runner.new(tree)
        }.map {|runner|
          runner.run
        }.collect &:stats
    end

    def report
      puts Specdown::Report.new(@results).generate
    end
  end
end
