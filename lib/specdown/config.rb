module Specdown
  module Config
    extend self

    attr_accessor :expectations
    attr_accessor :tests
    attr_accessor :root
    
    def test_environment_files
      unless @test_environment_files
        @test_environment_files = Dir["#{root}/**/*.rb"]
        unless root[0..0] == "/"
          @test_environment_files.map! {|file| File.join Dir.pwd, file}
        end
      end

      @test_environment_files
    end
    
    def root
      @root ||= "specdown"
    end

    def root=(new_root)
      if new_root[-1..-1] == "/"
        @root = new_root[0...-1]
      else
        @root = new_root
      end
    end

    def tests
      @tests ||= Dir["#{root}/**/*.markdown"] + Dir["#{root}/**/*.md"]
    end

    def tests=(test_files)
      @tests = test_files unless test_files.empty?
    end

    def reset!
      self.expectations = nil
    end
  end
end
