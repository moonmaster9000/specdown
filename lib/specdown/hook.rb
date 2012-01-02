module Specdown
  class Hook
    def initialize(*filters, &callback)
      @filters = filters
      @callback = callback
    end

    def matches?(filename)
      return true if @filters.empty?

      @filters.any? do |filter| 
        filter == filename || filter.match(filename)
      end
    end

    def call
      @callback.call
    end
  end
end
