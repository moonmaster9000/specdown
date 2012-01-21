Feature: Pending specs

  You can mark a spec as pending by using the "pending" method.

  For example, consider the following markdown file:

      Example of Pending Specification
      -----------------------------------

      This spec is pending.

          pending
 
 
  If you ran this with specdown, you'd receive the following output:


      P

      1 markdown
      1 test
      1 pending
      0 successes
      0 failures


  Scenario: Pending specification

    Given the following markdown with a pending spec:
      """
      # Example of Pending Specification

      This spec is pending.
      
      ```ruby
      pending
      ```
      """

   Then the `specdown` command should return the following output:
      """
      P

      1 markdown
      1 test
      1 pending
      0 successes
      0 failures
      """
