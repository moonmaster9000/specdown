module Specdown
  class ExceptionFacade
    def initialize(exception, runner)
      @exception = exception
      @runner = runner
    end

    def exception_class
      @exception.class
    end

    def exception_backtrace
      @exception.backtrace
    end

    def exception_message
      @exception.to_s
    end

    def test_filename
      @runner.file_name
    end
  end
end
