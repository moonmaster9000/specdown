module Specdown
  module Hooks
    extend self

    def reset!
      @before = []
      @after  = []
      @around = []
    end

    def matching_before_hooks(filename)
      filter before, filename
    end

    def matching_after_hooks(filename)
      filter after, filename
    end

    def matching_around_hooks(filename)
      filter around, filename
    end
    
    def before
      @before ||= []
    end

    def after
      @after  ||= []
    end

    def around
      @around ||= []
    end

    private
    def filter(hooks, filename)
      hooks.select {|hook| hook.matches? filename}
    end
  end
end
