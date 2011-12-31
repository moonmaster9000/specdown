module Specdown
  module EventServer
    extend self

    def event(event_name, *args)
      callbacks[event_name].map {|callback| callback.call *args} if callbacks[event_name] 
    end

    def register(event_name, &callback)
      callbacks[event_name] ||= []
      callbacks[event_name] << callback
    end

    private
    def callbacks
      @callbacks ||= {}
    end
  end
end
