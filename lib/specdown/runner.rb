module Specdown
  class Runner
    attr_reader :stats

    def initialize(tree)
      @tree   = tree
      @stats  = Stats.new
    end

    def run
      depth_first_search @tree.root
      puts "\n\n"
      self
    end

    private
    def depth_first_search(node, code=[])
      if node.children.empty?
        execute_test(code + [node.code])
      else
        node.children.each do |child|
          depth_first_search(child, (code + [node.code]))
        end
      end
    end

    def execute_test(code)
      @stats.tests += 1
      
      begin
        Sandbox.new.instance_eval do
          eval code.join("\n")
        end

        print '.'

      rescue Exception => e
        @stats.exceptions << e

        print 'F'
      end
    end
  end
end
