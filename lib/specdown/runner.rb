module Specdown
  class Runner
    attr_reader :stats, :file_path

    def initialize(file_path)
      @file_path = file_path
      @tree   = Parser.parse File.read(file_path)
      @stats  = Stats.new
    end

    def file_name
      File.basename @file_path
    end

    def run
      depth_first_search @tree.root
      EventServer.event :run_complete
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

        EventServer.event :test_passed

      rescue Exception => e
        @stats.exceptions << e

        EventServer.event :test_failed

      end
    end
  end
end
