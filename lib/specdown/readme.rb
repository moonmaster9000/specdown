module Specdown
  class Readme
    include ::Hook
    hook :execute

    attr_reader :tests, :stats, :file_path

    def initialize(file_path)
      @file_path  = file_path
      @tests      = []
      @stats      = Stats.new self
      build_tests
    end

    def exceptions
      @tests.collect(&:exception).compact
    end

    def pending_exceptions
      exceptions.select {|e| e.exception_class == Specdown::PendingException }
    end

    def undefined_implicits
      @tests.collect(&:undefined_implicits).flatten
    end

    def file_name
      File.basename @file_path
    end

    def execute
      with_hooks :execute do
        @tests.map &:execute
      end

      self
    end

    private
    def build_tests
      tree = Parser.parse File.read(file_path), Specdown::Config.implicit_specs
      depth_first_search(tree.root)
    end

    def depth_first_search(node, code=[], undefined_implicits=[])
      if node.children.empty?
        test = Specdown::Test.new self
        test.code = code + [node.code]
        test.undefined_implicits = undefined_implicits + node.undefined_implicits
        @tests << test
      else
        node.children.each do |child|
          depth_first_search(child, code + [node.code], undefined_implicits + node.undefined_implicits)
        end
      end
    end
  end
end
