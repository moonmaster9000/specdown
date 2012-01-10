module Specdown
  module SandboxFactory
    extend self

    def generate
      Module.new {}.tap do |sandbox|
        decorators.each do |decorator|
          decorator.call sandbox
        end
      end
    end

    def decorate(&block)
      decorators << block
    end

    private
    def decorators
      @decorators ||= []
    end
  end
end
