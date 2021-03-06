Feature: Specdown Parser

  The default specdown parser will convert a markdown file into a tree, with the headings inside the markdown forming the nodes of the tree.

  For example, imagine we are given following simple markdown file:

      readme = <<-README
      
        \# Specdown Example

        This is an example specdown file.

        \## Child Node

        This section is a child node. It contains some ruby code: 
            
        ```ruby
        "simple code".should_not be(nil)
        ```

        \### First Leaf

        This section has a failure simulation:
            
        ```ruby
        raise "specdown error simulation!"
        ```

        \## Last Leaf

        This section is a leaf node. It contains some ruby code:
        
        ```ruby
        1.should satisfy(&:odd?)
        ```
      README

  As you can see, this forms a tree, with "# Specdown Example" at the root of the tree, and "## Leaf 1" and "## Leaf 2" as the children / leafs. 

  then the Specdown::Parser would turn into the a tree data structure:

      tree = Specdown::Parser.parse readme

  You can ask for the root of the tree object via the `root` method:

      tree.root

  The root returned is a `Specdown::Parser::Node` object. A `Node` responds to four methods: `name`, `code`, `contents`, and `children`.

      tree.root.name.should == "Specdown Example"
      tree.root.code.should be(nil)
      tree.root.contents.should == "# Specdown Example\n\nThis is an example specdown file."
  
  The `children` method is simply an array of `Specdown::Parser::Node` objects, each corresponding to the children (if any) of the current node. 

      tree.root.children.first.name.should == "Leaf 1"
      tree.root.children.first.code.should == "1.should == 1"


  Scenario: Parsing a specdown file

    Given the following specdown example file:
      """
      # Specdown Example

      This is an example specdown file.

      ## Child Node

      This section is a child node. It contains some ruby code: 
          
      ```ruby
      "simple code".should_not be(nil)
      ```

      ### First Leaf

      This section has a failure simulation:
          
      ```ruby
      raise "specdown error simulation!"
      ```

      ## Last Leaf

      This section is a leaf node. It contains some ruby code:
      
      ```ruby
      1.should satisfy(&:odd?)
      ```
      """

    When I parse it into a tree:
      """
        @tree = Specdown::Parser.parse @readme
      """

    Then the root should be the "h1" section:
      """
        @tree.root.name.should == "Specdown Example"
        @tree.root.code.should be_empty
      """

    And the root should have two children:
      """
        @tree.root.children.length.should == 2
        
        child_node = @tree.root.children.first
        first_leaf = child_node.children.first
        last_leaf = @tree.root.children.last
        
        child_node.name.should  == "Child Node"
        child_node.code.should  == '"simple code".should_not be(nil)'

        first_leaf.name.should  == "First Leaf"
        first_leaf.code.should  == 'raise "specdown error simulation!"'
        
        last_leaf.name.should   == "Last Leaf"
        last_leaf.code.should   == "1.should satisfy(&:odd?)" 
      """


  Scenario: Parsing a specdown file

    Given the following specdown example file containing non-executing codeblocks:
      """
      # Specdown Example

      This is an example specdown file.

      ## Executing Code blocks

      This section contains an executing code block: 
          
      ```ruby
      "simple code".should_not be(nil)
      ```

      It also contains a non-executing code block:

          raise "I should not execute!"

      ## More non executing code blocks

      This section has two non-executing code blocks:

      ```javascript
      console.log("I won't execute!");
      ```

      and...

      ```
      $ cd /
      ```
      """

    When I parse it into a tree:
      """
        @tree = Specdown::Parser.parse @readme
      """

    Then the first leaf should contain only the explicit ruby code:
      """
        @tree.root.children.first.code.should == '"simple code".should_not be(nil)'
      """

    And the second leaf should not contain any executable code:
      """
        @tree.root.children.last.code.should be_empty
      """


  Scenario: Multiple code blocks in a section should join together with newlines

    Given the following specdown example file containing multiple executable codeblocks in a single section:
      """
      # Specdown Example

      This is an example specdown file.

      ```ruby
      hi = 'hello'
      ```

      ```ruby
      puts hi
      ```
      """

    When I parse it into a tree:
      """
        @tree = Specdown::Parser.parse @readme
      """

    Then the code blocks should be joined together with newlines:
      """
        @tree.root.code.should == "hi = 'hello'\nputs hi"
      """

  @focus
  Scenario: Code blocks + Undefined Implicit Specs

    Given the following README:
      """
      @readme = <<-README.undent
        # Specdown Example

        **This is an implicit spec.**

        This text has two implicit specs: **one** and **two**.

        ```ruby
        hi = "explicit spec"
        ```
      README
      """

    When I parse it into a tree:
      """
        @tree = Specdown::Parser.parse @readme
      """

    Then the root node should include the explicit code:
      """
        @tree.root.code.should == %{hi = "explicit spec"}
      """ 
      
    And the root node should include the undefined implicit specs:
      """
        @tree.root.undefined_implicits.should == ["This is an implicit spec.", "one", "two"]
      """

  @focus
  Scenario: Code blocks + Defined Implicit Specs

    Given the following README:
      """
      @readme = <<-README.undent
        # Specdown Example

        **This is an implicit spec.**

        ```ruby
        hi = "explicit spec"
        ```
      README
      """

    And the following implicit specs:
      """
        @implicits = <<-SPECDOWN.undent
          This is an implicit spec.
          -----------------------------

              puts "howdy"
        SPECDOWN
      """

    When I parse it into a tree:
      """
        @tree = Specdown::Parser.parse @readme, Specdown::ImplicitParser.parse(@implicits)
      """

    Then the code block and the implicit spec should be joined together:
      """
        @tree.root.code.should == %{puts "howdy"\nhi = "explicit spec"}
      """
