module Specdown
  class Command
    include ::Hook
    hook :execute

    attr_reader :readmes

    def initialize
      @readmes = []
    end

    def execute
      with_hooks :execute do
        load_test_environment
        parse_options
        run
      end

      exit exit_status
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
