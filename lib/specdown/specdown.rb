module Specdown
  extend self
  
  def sandbox
    SandboxFactory.generate
  end
end
