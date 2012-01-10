Specdown::SandboxFactory.decorate do |sandbox|
  if Specdown::Config.expectations == :rspec
    require 'rspec/expectations'
    sandbox.extend ::RSpec::Matchers 
  end
end
