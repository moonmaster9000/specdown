module Specdown
  class Command
    def initialize
      @markdowns = Dir["specdown/**/*.markdown"]
    end

    def execute
      run
      Specdown::EventServer.event :command_complete, @results
    end
    
    private
    def run
      @results = @markdowns.map {|markdown| Runner.new(markdown).run.stats}
    end
  end
end
