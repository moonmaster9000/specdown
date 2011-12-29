Feature: Specdown Parser

  The default specdown parser will convert a markdown file into a tree, with the headings inside the markdown forming the nodes of the tree.

  For example, imagine we are given following simple markdown file:

      readme = <<-README
      
      \# Specdown Example

      This is an example specdown file.

      \## Leaf 1

      This section is a leaf node. It contains some ruby code:

          1.should == 1

      \## Leaf 2

      This section is also a leaf node. It contains some ruby code as well: 
          
          raise "specdown error simulation!"

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

      ## First Leaf

      This section is a leaf node. It contains some ruby code:

          1.should == 1

      ## Child Node

      This section is also a leaf node. It contains some ruby code as well: 
          
          raise "specdown error simulation!"       
      
      ## Last Leaf

      This section has no code.
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
        child_node.code.should  == 'raise "specdown error simulation!"'

        first_leaf.name.should  == "First Leaf"
        first_leaf.code.should  be_empty
        
        last_leaf.name.should   == "Last Leaf"
        last_leaf.code.should   == "1.should == 1" 
      """
