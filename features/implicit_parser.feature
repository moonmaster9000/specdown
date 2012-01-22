Feature: Specdown::ImplicitParser

  The Specdown::ImplicitParser will parse ".specdown" files.

  Imagine the following file "implicits.specdown":


      some text
      ==================
      
          some code



      some more text
      ==================

          some more code


  We can pass it off to the Specdown::ImplicitParser as a string:

      result = Specdown::ImplicitParser File.read("implicits.specdown")

  The result will be a hash lookup for the definitions:

      result.should == {
        "some text" => "some code",
        "some more text" => "some more code"
      }


  Note that, unlike a regular markdown file that you ask specdown to execute, specdown does not care about the header levels inside your ".specdown" files.
 

  Scenario: Multiple Implicits

    Given the following implicit specification:
      """
        @implicits = <<-SPECDOWN.undent
          a
          -----------------

              a code


          b
          ===================

              b code
          

          c
          ------------------

          here's the c code:
              
              c code
          
          plus some more c code:

              more c code

        SPECDOWN
      """
    
    When I parse it with the implicit parser: 
      """
        @result = Specdown::ImplicitParser.parse @implicits
      """

    Then I should receive a hash lookup of implicit definitions:
      """
        @result.should == {
          "a" => "a code",
          "b" => "b code",
          "c" => "c code\nmore c code"
        }
      """

  Scenario: Several implicit specification strings

    Given two implicit specification strings:
      """
        @implicits_1 = <<-SPECDOWN.undent
          a
          ---------------

              a code
        SPECDOWN

        @implicits_2 = <<-SPECDOWN.undent
          b
          --------------

          ```ruby
          b code
          ```
        SPECDOWN
      """
    
    When I pass both off to the Specdown::ImplicitParser:
      """
        @results = Specdown::ImplicitParser.parse @implicits_1, @implicits_2
      """

    Then I should receive a hash lookup of implicit definitions:
      """
        @results.should == {
          "a" => "a code",
          "b" => "b code"
        }
      """
