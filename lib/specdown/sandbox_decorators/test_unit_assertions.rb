Specdown::SandboxFactory.decorate do |sandbox|
  if Specdown::Config.expectations == :test_unit
    require 'test/unit/assertions'
    sandbox.extend ::Test::Unit::Assertions 
  end
end
