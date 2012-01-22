module Specdown
  module Config
    extend self

    attr_accessor :expectations
    attr_accessor :tests
    attr_accessor :root
    attr_accessor :reporter
    attr_accessor :format

    def format
      @format ||= :condensed
    end

    def reporter
      @reporter ||= Specdown::ColorTerminalReporter
    end
    
    def reset!
      @expectations = nil
      @reporter     = nil
      @root         = nil
      @format       = nil
    end

    def root
      @root ||= "specdown"
    end

    def root=(new_root)
      @root = strip_trailing_slash new_root
    end

    def tests
      @tests ||= find_tests_in root
    end

    def implicit_specs
      return @implicit_specs if @implicit_specs
      implicit_spec_files = find_implicit_specs_in(root).map {|file| File.read(file)}
      @implicit_specs = Specdown::ImplicitParser.parse *implicit_spec_files
    end

    def tests=(test_files)
      unless test_files.empty?
        @tests = test_files

        @tests.map! do |test_dir|
          if File.directory? test_dir
            find_tests_in test_dir
          else
            test_dir
          end
        end.flatten!
      end
    end
    
    def test_environment_files
      unless @test_environment_files
        @test_environment_files = Dir["#{root}/**/*.rb"]
        unless root[0..0] == "/"
          @test_environment_files.map! {|file| File.join Dir.pwd, file}
        end
      end

      @test_environment_files
    end

    private
    def find_tests_in(directory)
      directory = strip_trailing_slash directory
      Dir["#{directory}/**/*.markdown"] + Dir["#{directory}/**/*.md"]
    end

    def find_implicit_specs_in(directory)
      directory = strip_trailing_slash directory
      Dir["#{directory}/**/*.specdown"]
    end

    def strip_trailing_slash(string)
      if string[-1..-1] == "/"
        string[0...-1]
      else
        string
      end
    end
  end
end
