# specdown

Write your README in markdown, and execute it with specdown. Documentation == Specification == WINNING

## Why?

I love README DRIVEN DEVELOPMENT. I love the free-form nature of writing a README. I dislike the process of copying and transforming my README into cucumber. Gherkin works well for some types of requirements, but I dislike turning readable, natural prose into "Given/When/Then" Gherkin. I dislike turning my readable prose into RSpec even more.

## How?

Writing your tests with specdown is as simple as writing a README. I'll show you. 

Let's imagine we're writing a README for a silly little ruby library called "Todo":

    # Todo

    A simple library for managing your todo list. 

    ## Usage

    Go into `irb`, then `require 'todo'`. Type `Todo.List` to see your current to do list:

        Todo.List #==> []

    If at any point, you want to completely reset your Todo.List, simply call `Todo!`:
        
        Todo!
        Todo.List.should be_empty

    ### Adding/Removing

    Now, add an item to your to-do list by calling it as if it were a method on the `Todo` object:

        Todo.shop_for_groceries
    
    This added the item to your `Todo.List`:

        Todo.List.should == [:shop_for_groceries]

    You can remove an item from your todo list by adding an exclamation point onto the end of it:
        Todo.shop_for_groceries!
        Todo.List.should be_empty
    

    ### Bulk operations

    You can also perform bulk operations on your `Todo.List`:
      
        Todo.edit! do 
          shop
          dry_cleaning!
          shave!
          walk_dogs
        end

    The items "dry_cleaning" and "shave" were removed from your `Todo.List`, and the items "shop" and "walk_dogs" were added to your Todo.List.

        Todo.List.should == [
          :shop,
          :walk_dogs
        ]

Let's call this file "README.markdown", and place it inside a "specdown/" directory:

    $ ls -r
      specdown/
        README.markdown

We can execute this markdown with specdown by simply the `specdown` command. If you'd like to have some code run before the markdown is executed, put it in a ruby file inside a "specdown" directory:

    $ cat > specdown/support.rb
      
      $LOAD_PATH.unshift './lib'
      require 'rspec/expectations' # for using "should" matchers in the README
      require 'todo'

## Trees and Leafs

In the README that we wrote for `Todo`, we actually wrote two tests, or scenarios. 

`specdown` creates a tree out of our markdown. In our case, the tree for our `Todo` README looks like this:


                  #Todo
                    |
                  ##Usage
                  /    \
                 /      \
                /        \
               /          \
              /            \
             /              \
            /                \
    ###Adding/Removing       ###Bulk Operations

`specdown` will then walk the path from the root to every leaf node in the tree, executing any code it finds along the way.

Thus, the first "test" will look like this:

    Todo.List #==> []
    Todo!
    Todo.List.should be_empty
    Todo.shop_for_groceries
    Todo.List.should == [:shop_for_groceries]
    Todo.shop_for_groceries!
    Todo.List.should be_empty

The second "test" looks like this:

    Todo.List
    Todo!
    Todo.List.should be_empty
    Todo.edit! do 
      shop
      dry_cleaning!
      shave!
      walk_dogs
    end
    Todo.List.should == [
      :shop,
      :walk_dogs
    ]
