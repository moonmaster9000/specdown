module Specdown
  class ExceptionFacade
    def initialize(exception, readme)
      @exception = exception
      @readme = readme
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
      @readme.file_name
    end
  end
end
