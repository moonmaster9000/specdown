module Specdown
  class Command
    def execute
      load_test_environment
      parse_options
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
      @results = []
      
      Kernel.at_exit do
        Specdown::EventServer.event :command_complete, @results
      end
      
      Specdown::Config.tests.each do |markdown| 
        @results << Runner.new(markdown)
        @results.last.run
      end
    end
  end
end
