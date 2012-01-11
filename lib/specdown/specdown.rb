module Specdown
  extend self
  
  def reset!
    Config.reset!
    Hooks.reset!
  end

  def sandbox
    SandboxFactory.generate
  end

  def reporter
    @reporter ||= Config.reporter.new
  end

  def before(*filters, &callback)
    Hooks.before << Hook.new(*filters, &callback)
  end

  def after(*filters, &callback)
    Hooks.after << Hook.new(*filters, &callback)
  end

  def around(*filters, &callback)
    Hooks.around << Hook.new(*filters, &callback)
  end
end
