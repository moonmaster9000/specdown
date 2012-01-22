module Specdown
  class Runner
    attr_reader :stats, :file_path

    def initialize(file_path)
      @file_path = file_path
      @tree   = Parser.parse File.read(file_path), Specdown::Config.implicit_specs
      @stats  = Stats.new self
    end

    def file_name
      File.basename @file_path
    end

    def run
      EventServer.event :run_started, self
      depth_first_search @tree.root
      EventServer.event :run_complete, self
      self
    end

    private
    def depth_first_search(node, code=[], undefined_implicits=[])
      if node.children.empty?
        EventServer.event :before_test, self
        execute_test(code + [node.code], undefined_implicits + node.undefined_implicits)
        EventServer.event :after_test, self
      else
        node.children.each do |child|
          depth_first_search(child, (code + [node.code]), (undefined_implicits + node.undefined_implicits))
        end
      end
    end

    def execute_test(code, undefined_implicits)
      @stats.tests += 1

      if !undefined_implicits.empty?
        @stats.undefined_implicits += undefined_implicits
        EventServer.event :test_undefined, self
      else
      
        begin
          Specdown.sandbox.instance_eval <<-CODE, file_name
            #{code.join("\n")}
          CODE
          EventServer.event :test_passed, self

        rescue Specdown::PendingException => e
          @stats.pending_exceptions << ExceptionFacade.new(e, self)
          EventServer.event :test_pending, self

        rescue Exception => e
          @stats.exceptions << ExceptionFacade.new(e, self)
          EventServer.event :test_failed, self
        end
      end
    end
  end
end
