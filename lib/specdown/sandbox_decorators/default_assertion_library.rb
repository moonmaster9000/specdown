Specdown::SandboxFactory.decorate do |sandbox|
  if Specdown::Config.expectations.nil?
    begin
      require 'rspec/expectations'
      sandbox.extend ::RSpec::Matchers
    rescue LoadError => e
      require 'test/unit/assertions'
      sandbox.extend ::Test::Unit::Assertions 
    end
  end
end
