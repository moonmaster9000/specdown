module Specdown
  class Test
    include ::Hook
    hook :execute

    attr_accessor :code, :undefined_implicits
    attr_reader :status, :exception, :readme

    def initialize(readme=nil)
      @readme               = readme
      @code                 = []
      @undefined_implicits  = []
    end

    def execute   
      with_hooks(:execute) do
        execute_code 
      end
    end

    private

    def execute_code
      if @undefined_implicits.empty? == false
        @status = :undefined
      else
        begin
          Specdown.sandbox.instance_eval @code.join("\n")
          @status = :passing
        rescue Exception => e
          @status = e.class == Specdown::PendingException ? :pending : :failing
          @exception = Specdown::ExceptionFacade.new e, @readme
        end      
      end
    end
  end
end