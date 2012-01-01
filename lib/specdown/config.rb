module Specdown
  module Config
    extend self

    attr_accessor :expectations

    def reset!
      self.expectations = nil
    end
  end
end
