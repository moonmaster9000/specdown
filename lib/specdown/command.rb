module Specdown
  class Command
    def execute
      parse_options
      load_test_environment
      run
    end
    
    private
    def parse_options
      Specdown::OptionParser.parse!
    end

    def load_test_environment
      Specdown::Config.test_environment_files.each do |file|
        Kernel.load file
      end
    end

    def run
      @results = Specdown::Config.tests.map {|markdown| Runner.new(markdown).run.stats}
      Specdown::EventServer.event :command_complete, @results
    end
  end
end
