# specdown

Write your README in markdown, and execute it with specdown. 

## Why?

Simply put, `specdown` takes README DRIVEN DEVELOPMENT one step further by making your markdown executable.

If you don't know what README DRIVEN DEVELOPMENT IS, checkout Tom Preston Werner's [README Driven Development](http://tom.preston-werner.com/2010/08/23/readme-driven-development.html)

## CAVEAT

This library is _barely_ released. It's version 0.0.1. You can write your tests with it, but only barely. Stay tuned for more features, or fork and implement them (see the TODO list at the end of this README).

## Installation

Right now, specdown only support's Ruby. Next, I'll write a javascript implementation. Then, I don't know what language. Regardless, the goal is that you could use specdown with any programming language you desire.

To install the `specdown` ruby gem, simply:

    $ gem install specdown

It comes with a `specdown` command. Try running it. Doesn't matter where.

## Usage

Let's write a simple test in markdown, and execute it with specdown. Create a "specdown" directory, then save the following text into a file inside of it. I'll assume you're calling it "example.markdown":

    # Our first test!

    This is our very first test. It's going to blow your mind.

        raise "WTF?" unless 1 == 1

Ok, if you've been following along, then `ls -R` should return the following directory structure:

    $ ls -R
      
      specdown/
        example.markdown

Great. Now run the `specdown` command:

    $ specdown

        .

        1 markdown
        1 test
        0 failures

Booya!

### How does it work?

`specdown` loads any "markdown" files it can find inside the "specdown" directory, parses them into trees, then performs exhaustive depth-first searches on the trees to execute the code.

Let's update our README to help illustrate this:

    # Our first test!

    This is our very first test. It's going to blow your mind.

        raise "WTF?" unless 1 == 1

    ## A Subsection

    In this section, we're going to create a variable.

        name = "moonmaster9000"

    ### A sub subsection

    In this subsection, we have access to anything created or within scope in parent sections:

        raise "name not in scope" if !defined? name

    ## Another Subsection

    In this subsection, we don't have access to the "name" variable. Think of your markdown as a tree.

        raise "name in scope" if defined? name

Read through that. I'm giving you some important scoping hints in it. 

Save it, run it.

    $ specdown

        ..
        
        1 markdown
        2 tests
        0 failures

Notice how the headers in your markdown form a tree?

                #Our first test!
                    /    \
                   /      \
                  /        \
                 /          \
                /            \
               /              \
              /                \
      ##A Subection       ##Another Subsection
            /
           /
          /
    ###A sub subsection

Specdown turned that tree into two tests. The first test (#Our first test! --> ##A Subsection --> ###A sub subsection):

        raise "WTF?" unless 1 == 1
        name = "moonmaster9000"
        raise "name not in scope" if !defined? name

Here's what the second test looked like (#Our first test! --> ##Another Subsection)

        raise "WTF?" unless 1 == 1
        raise "name in scope" if defined? name

### Using RSpec "should" expectations

If you put a ruby file somewhere inside your "specdown" directory, `specdown` will find it and load it. How is that useful? Perhaps you'd like to use the RSpec expectation library instead of manually raising exceptions in your tests. Simple:

    $ mkdir specdown/support/
    $ echo "require 'rspec/expectations'" > specdown/support/env.rb

Now you can remove all of those `raise` with rspec `should` notation.

### Using Test::Unit::Assertions

Create a "specdown/support/env.rb" file in your app, then add the following to it:

    require 'test/unit/assertions'
    include Test::Unit::Assertions

You can now replace all of those `raise` with test unit `assert` methods.

## TODO

This library is the result of about 8 hours worth of work so far :-) It's a basic minimum viable product, but there are tons of features I want to implement. Here's what's on my immediate horizon:

* Test hooks (before/after/around)
* Run a single test
* color code the terminal output
* offer the option of outputing the actual markdown while it executes, instead of "..F....FF......"
