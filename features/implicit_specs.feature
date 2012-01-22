Feature: Implicit Specs

  In all of the examples so far, we've made all code that we want executed
  explicit within the markdown. Sometimes, however, it's advantageous to
  simply state a specification, and then map that to code
  behind-the-scenes. They're conceptually equivalent to cucumber step
  definitions.

  Imagine we've written the following markdown for an imaginary `Article`
  model:

      \# Deleting an article from the database
      
      Imagine we create the following article:

      ```ruby
      article = Article.create :title => "Specdown"
      ```

      We can delete the article by simply using the `delete!` method:
      
      ```ruby
      article.delete!
      ```

      **The article should now be deleted from the database.**

  Notice the emphasis around the last sentence. If we execute this with
  `specdown`, we'll recieve the following result:

  ```sh
  $ specdown

      1 markdown
      1 test
      0 passing
      0 failing
      1 undefined

      
      Now add the following implicit spec definition to a file suffixed with ".specdown":

      The article should now be deleted from the database.
      ------------------------------------------------------
              
          pending # replace this with the code you want
  ```

  If we do as it says and rerun the `specdown` command, we'll receive a
  notice that we now have a pending implicit spec. Thus, we could
  implement the pending spec like so (assuming we were using RSpec
  expectations):

  ```markdown
  The article should now be deleted from the database.
  --------------------------------------------------------

      Article.all.should be_empty
  ```

  The ".specdown" file is simply a markdown file with a different
  extension. It should consist of an unordered list of spec / definition pairs.

  Note that, according to the [markdown specification](http://daringfireball.net/projects/markdown/syntax#list), codeblocks within list items must be indented twice (two tabs or 8 spaces).


  Scenario: No implicit specification

    Given a markdown file with an implicit spec:
      """
        # Heading

        **An implicit spec.**
      """
    But no implicit specification
    When I run the `specdown` command
    Then I should see the following output:
      """
        1 undefined

        Now add the following implicit spec definition to a file suffixed with ".specdown":

        An implicit spec.
        ------------------------------------------------------
            
            pending # replace this with the code you wish you had
      """
  
  Scenario: Pending implicit specification
    Given a markdown file with an implicit spec:
      """
        # Heading

        **An implicit spec.**
      """

    And a specdown file with a pending specification:
      """
      An implicit spec.
      ---------------------

          pending
      """

    When I run the `specdown` command
    Then I should see the following output:
      """
        1 pending
      """
 
  Scenario: Complete implicit specification
    Given a markdown file with an implicit spec:
      """
        # Heading

        **An implicit spec.**
      """
    
    And a specdown file with a complete specification:
      """
        An implicit spec.
        ----------------------

            raise "oops!" unless 1 == 1
      """

    When I run the `specdown` command

    Then I should see the following output:
      """
        1 success
        0 failures
      """


