# specdown

[![Build Status](https://secure.travis-ci.org/moonmaster9000/specdown.png)](http://travis-ci.org/moonmaster9000/specdown)

Write your README in markdown, and execute it with specdown. 

## Why?

When you write a README for a library, a class, a command, etc., you're
forced to stop and consider your user:

* How are they going to use it?
* What kind of API should I provide?
* How can I convince someone to use my library?

What if you write the README first, before writing your tests or your code? This is the
premise of README Driven Development. See Tom Preston-Werner's [blog post](http://tom.preston-werner.com/2010/08/23/readme-driven-development.html)
on the topic for a quick introduction to all of its benefits.

### Duplication

One pain point I've encountered with README Driven Development is
duplication between my tests and my documentation. Quite often, I'll end up
spending a good deal of time translating most of my README's into executable tests in Cucumber or
RSpec. Not only does this lower my productivity, it also forces me to
maintain information about my code in two places: the documentation, and
the tests. 

Wouldn't it be great if your documentation and your tests were one and
the same? For me, this was the promise of Cucumber, a tool I still use
and love. However, I find that the repetitive nature of Gherkin, along
with the hidden nature of the step definitions, mitigates against the
likelihood that my feature files will actually serve as the primary
documentation for my project. Readers will tune out when asked to read a page full of
repetitive "Given/When/Then" scenarios, or they'll be forced to look elsewhere for the
information they need because the step definitions hide the API.

## Installation

Right now, specdown only supports Ruby. Next, I'll write a javascript implementation. Then, I don't know what language. Regardless, the goal is that you could use specdown with any programming language you desire.

To install the `specdown` ruby gem, simply:

    $ gem install specdown

It comes with a `specdown` command. Try running it. Doesn't matter where.

## Tutorial

The quickest way to learn specdown is to develop a simple ruby library with it. This tutorial should take about 10 minutes. Feel free to skip to the specdown command line reference at the end of this README.

Let's develop a simple todo list library. We'll be using [github-flavored](http://github.github.com/github-flavored-markdown/) markdown for all of our specdown. 

We'll start by describing our library:

    Todo
    ====================

    The `todo` gem provides a simple ruby DSL for managing your TO DO list via IRB. 


    Why?
    --------------------------
    
    Most people would prefer to manage their TODO list through a website, mobile app, or desktop app.
    But some geeks prefer doing everything in the terminal. If you're that kind of geek, read on.


    Installation
    --------------------------

    To get started, first install the "todo" gem:

        $ gem install todo
    
    Next, fire up IRB and load your gem:

        $ irb
        > require 'rubygems'
        > require 'todo'
    
    You're now ready to start interacting with your TODO list via the IRB prompt. 


Our readme tells you what the library is, why you might want to use it, and how to get started.  

We haven't written any real code yet, but let's go ahead and let specdown take a crack at executing it. Save your readme in your current working directory (I'm going to assume you call it "readme.markdown"), then run `specdown readme.markdown` at the command line.

    $ specdown readme.markdown
      
      readme.markdown: ..

      1 markdown
      2 tests
      2 passing
      0 failures

Interesting. Specdown found two tests inside our README, then executed them and found that they were passing. But what were those tests?

Specdown works by parsing a README into a tree, letting the header structure form the nodes of the tree. Here's what our tree looks like so far:

                    #Todo
                    /    \
                   /      \
                  /        \
                 /          \
                /            \
               /              \
              /                \
          ##Why?             ##Installation

Specdown performs an exhaustive depth-first search on the tree from the root to each leaf, collecting `ruby` codeblocks along the way. Our two tests are thus:

* #Todo -> ##Why?
* #Todo -> ##Installation

However, at this point we have not yet written any `ruby` code blocks inside our markdown, so the tests are empty (and therefore passing by default). Let's change that. Add the following section to the end of your README:

    Usage
    -------------------

    You'll use the `todo` method to interact with your list. For example, to see what's inside your list, simply call the `todo` method:

    ```ruby
    todo #==> []
    ```


We've just created our first executable test. When we surrounded the `todo` code with a `ruby` backtick fence, we told specdown to execute that code. The "#==> []" is of course not executable - it's just a comment. 

Now if you run the specdown command, you'll get an exception report telling you that the "todo" constant is undefined:

    $ specdown readme.markdown
      
      readme.markdown: ..F

      ----------------------------
      1 markdown
      2 tests
      1 passing
      1 failing
      ----------------------------

      In readme.markdown: #<NameError>: (eval):2:in `execute_code': undefined local variable or method `todo'


How can we rectify that?

Create a "todo.rb" file inside your current working directory, and add the following code to it:

```ruby
def todo
end
```

Then, create a "specdown" directory inside your current working directory and add another ruby file "specdown/env.rb" with the following code:

```ruby
require "todo"
```

Run the specdown command again, and all tests should pass.

Next, let's show people how to add items to our `todo` list:

      
    To add an item to your `todo` list, simply pass a string to the `todo!` method:

    ```ruby
    todo! 'buy groceries'
    ```
    
    **"buy groceries" is now in your todo list.** Call the `todo` method again to confirm.

    Lastly, to remove an item from your list, pass it to the `done!` method:

    ```ruby
    done! 'buy groceries'
    ```
    
    **Your list should now be empty again**.

Notice that we surrounded some assertions with double stars. Run the `specdown` command and it will report an undefined "implicit" assertion:

    $ specdown readme.markdown
      
      readme.markdown: ..U

      ----------------------------
      1 markdown
      2 tests
      1 passing
      1 undefined
      0 failures
      ----------------------------


      Now add the following implicit spec definition to a file suffixed with ".specdown":

      "buy groceries" is now in your todo list
      ----------------------------------------

          pending # replace this with the code you wish you had


      Your list should now be empty again
      -----------------------------------

          pending # replace this with the code you wish you had



Create a "specdown" directory inside your current working directory, then add markdown to it. (Note: "specdown" files simply contain markdown, but are interpreted by specdown as containing implicit specifications. If you've used cucumber before, you can think of these as something similar to a cucumber step definition.)

If you rerun the `specdown` command, you'll get notified that your test is pending now. We can fill in the implicit specifications thusly. I'd like to use RSpec `should` expectations to fill out my tests; luckily, if specdown detects that the "rspec" gem is installed, it will make RSpec expectations available to your tests. Otherwise, it will default to `test/unit` assertions. We can ensure that "rspec" expectations are available in our tests by creating a Gemfile inside our current working directory with the following content:

    source "http://rubygems.org"

    gem "rspec"
    gem "specdown"

Now run `bundle` at the command line. Next, update your "readme.specdown" file and fill out the tests:

    "buy groceries" is now in your todo list
    ----------------------------------------

        todo.should include("buy groceries")


    Your list should now be empty again
    -----------------------------------

        todo.should be_empty

Great! Now run `bundle exec specdown readme.markdown` and watch your tests fail! Keep it up, implementing just enough code to get your all of your tests passing.  

### Implicit v. Explicit Assertions

Note that nothing requires us to create implicit assertions. We could have just as easily embedded these assertions in our main readme:

    To add an item to your `todo` list, simply pass a string to the `todo` method:

    ```ruby
    todo! 'buy groceries'
    todo.should include('buy groceries')
    ```
    
    Call the `todo` method yourself to confirm.

    Lastly, to remove an item from your list, pass it to the `done!` method:

    ```ruby
    done! 'buy groceries'
    todo.should be_empty
    ```

However, we've sacrificied the readability (and utility) of our README by doing so.


## Setting up your test environment

Similar to the cucumber testing framework: if you put a ruby file somewhere inside your "specdown" directory, `specdown` will find it and load it.

### Configuring the Expectation / Assertion framework

As of version 0.1.0, `specdown` supports both RSpec expectations and Test::Unit assertions. 

Specdown will default to RSpec expectations, but if it can't find the "rspec" gem installed on your system, it will fall back to Test::Unit assertions.

You can also configure `Specdown` manually to use RSpec expectations or Test::Unit assertions. 

#### RSpec expectations

Create a "support" directory inside your specdown directory, and add an `env.rb` file containing the following Ruby code:

```ruby
Specdown::Config.expectations = :rspec
```

You can now use [RSpec expectations](https://www.relishapp.com/rspec/rspec-expectations) in your tests. 

#### Using Test::Unit::Assertions

Create a "specdown/support/env.rb" file in your app, then add the following to it:

```ruby
Specdown::Config.expectations = :test_unit
```

You can now use [Test::Unit::Assertions](http://www.ruby-doc.org/stdlib-1.9.3/libdoc/test/unit/rdoc/Test/Unit/Assertions.html) inside your tests.

## Test hooks (before/after/around)

You can create test hooks that run before, after, and around tests. You can create global hooks, or hooks that run only for specific specdown files.

### Global hooks

To create a global before hook, use the `Specdown.before` method:

```ruby
Specdown.before do
  puts "I run before every single test!"
end
```

That before hook will - you guessed it - RUN BEFORE EVERY SINGLE TEST.

Similary, you can run some code after every single test via the `Specdown.after` method:

```ruby
Specdown.after do
  puts "I run after every single test!"
end
```

Whenever you need some code to run before _and_ after every single test, use the `Specdown.around` method:

```ruby
Specdown.around do
  puts "I run before _AND_ after every single test!"
end
```

### Scoping your hooks to specific markdown files

You might, at times, want hooks to run only for certain files. 

You can pass filenames (or regular expressions) to the `Specdown.before`, `Specdown.after`, and `Specdown.around` methods. The hooks will then execute whenever you execute any markdown file with matching filenames.

```ruby
Specdown.before "somefile.markdown", /^.*\.database.markdown$/ do
  puts "This runs before every test within 'somefile.markdown', and
        before every test in any markdown file whose filename ends 
        with '.database.markdown'"
end
```

## specdown command line

You can run `specdown -h` at the command line to get USAGE and options.

If you run `specdown` without any arguments, specdown will look for a "specdown" directory inside your current working directory, then search for any markdown files inside of it, and also load any ruby files inside of it.

### Running specific files (or directories)

If you want to run just a single file or a set of files, or a directory of files, simply pass them on the command line:

```sh
$ specdown specdown/test.markdown
$ specdown specdown/unit_tests specdown/simple.markdown specdown/integration_tests/
```

### Overriding the default root directory

You can use the `-r` flag to specify the root of the specdown directory (it defaults to "specdown/"). 

```sh
$ specdown test.markdown -r specdown_environment/
```

### Colorization

By default, `specdown` will output colorized terminal output. If you'd rather the output not be colorized, you can use the `-n` or `--non-colorized` switch:

```sh
$ specdown -n
```

You can also turn off colorization in your env.rb by setting the
reporter to `Specdown::TerminalReporter`:

```ruby
Specdown::Config.reporter = Specdown::TerminalReporter
```

The reporter defaults to `Specdown::ColorTerminalReporter`.

### Report format: short or condensed

Currently, we offer two report formats: short and condensed. Short
offers only the most basic information, whereas `condensed` will provide
you with summary details per file.

You can toggle between the two either by setting switches at the command
line:

```sh
$ specdown -f short
$ specdown --format=short
$ specdown -f condensed
$ specdown --format=condensed
```

You can also configure this in your env.rb by setting
`Specdown::Config.format` to either `:short` or `:condensed`:

```ruby
Specdown::Config.format = :short
```

The default is `:condensed`.

## LICENSE

This software is [public domain](http://en.wikipedia.org/wiki/Public_domain). GO WILD
