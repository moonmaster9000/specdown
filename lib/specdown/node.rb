module Specdown
  class Node
    attr_accessor :name, :code, :contents, :children, :parent

    def initialize
      @code = ''
      @contents = ''
      @children = []
    end

    def code
      @code.strip
    end
  end
end
