module Specdown
  class Node
    attr_accessor :name, :code, :undefined_implicits, :contents, :children, :parent

    def initialize
      @code = ''
      @contents = ''
      @children = []
      @undefined_implicits = []
    end

    def code
      @code.strip
    end
  end
end
