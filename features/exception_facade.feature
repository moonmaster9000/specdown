Feature: Specdown::ExceptionFacade

  A `Specdown::ExceptionFacade` is simply a convenient, no fuss way to retrieve useful information about an exception thrown during a specdown test run. You simply have to supply it with a stat, and the raw exception, and Specdown will do the rest.

  For example, given the following exception:
      
      exception = Exception.new "exception simulation"

  And given the following fake test readme:

      readme = Class.new { attr_accessor :file_name }.new
      readme.file_name = "test_file.markdown"

  We can now generate an exception facade:

      exception_facade = Specdown::ExceptionFacade.new exception, readme

      exception_facade.test_filename.should       == "test_file.markdown"
      exception_facade.exception_class.should     == Exception
      exception_facade.exception_backtrace.should include("exception simulation")


  Scenario: Exception report generated from a test run
    Given the following exception: 
      """
        @exception = Exception.new "exception simulation"
      """

    And the following fake readme:
      """
        @readme = Class.new { attr_accessor :file_name }.new
        @readme.file_name = "test_file.markdown"
      """

    When I generate an exception facade:
      """
        @exception_facade = Specdown::ExceptionFacade.new @exception, @readme
      """

    Then it should return all kinds of information about the exception and it's context:
      """
        @exception_facade.test_filename.should       == "test_file.markdown"
        @exception_facade.exception_class.should     == Exception
        @exception_facade.exception_backtrace.should be(nil)
      """
 
