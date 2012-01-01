module Specdown
  module SandboxFactory
    extend self

    def generate
      Module.new {}.tap do |sandbox|
        setup_expectation_library.call(sandbox)
      end 
    end

    private
    def setup_expectation_library
      expectation_library_setups[Config.expectations] 
    end
    
    def expectation_library_setups
      Hash.new(default_expectations_setup).tap do |setups|
        setups[:rspec]     = rspec_expectations_setup
        setups[:test_unit] = test_unit_expectations_setup
      end
    end

    def rspec_installed?
      require_rspec
    end

    def require_rspec
      begin
        require('rspec/expectations')
        true
      rescue LoadError
        false
      end
    end

    def default_expectations_setup
      if rspec_installed?
        rspec_expectations_setup 
      else
        test_unit_expectations_setup
      end
    end

    def rspec_expectations_setup
      require_rspec
      proc {|sandbox| sandbox.extend ::RSpec::Matchers}
    end

    def test_unit_expectations_setup
      proc do |sandbox|
        require 'test/unit/assertions'
        sandbox.extend ::Test::Unit::Assertions
      end
    end
  end
end
