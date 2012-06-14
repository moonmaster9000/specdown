module Specdown
  extend self
  
  def reset!
    Config.reset!
  end

  def sandbox
    SandboxFactory.generate
  end

  def reporter
    @reporter ||= Config.reporter.new
  end

  def before(*filters, &callback)
    Specdown::Test.hook_before(:execute) do |test|
      if filters.empty? || filters.any? {|filter| filter.match test.readme.file_name}
        callback.call
      end
    end
  end

  def after(*filters, &callback)
    Specdown::Test.hook_after(:execute) do |test|
      if filters.empty? || filters.any? {|filter| filter.match test.readme.file_name}
        callback.call
      end
    end
  end

  def around(*filters, &callback)
    Specdown::Test.hook_around(:execute) do |test|
      if filters.empty? || filters.any? {|filter| filter.match test.readme.file_name}
        callback.call
      end
    end
  end
end
