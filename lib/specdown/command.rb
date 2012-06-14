module Specdown
  class Command
    include ::Hook

    attr_reader :readmes

    def initialize
      @readmes = []
    end

    def execute_with_hooks
      execute

      exit exit_status
    end

    +hook
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
      Specdown::Config.tests.each do |markdown| 
        @readmes << Specdown::Readme.new(markdown)
        @readmes.last.execute
      end
    end

    def exit_status
      @readmes.all? &:passing?
    end
  end
end
