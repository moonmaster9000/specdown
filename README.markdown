# specdown

Write your README in markdown, and execute it with specdown. 

## Why?

Simply put, `specdown` takes README DRIVEN DEVELOPMENT one step further by making your markdown executable.

If you don't know what README DRIVEN DEVELOPMENT IS, checkout Tom Preston Werner's blog post ["README Driven Development"](http://tom.preston-werner.com/2010/08/23/readme-driven-development.html)

## CAVEAT

This library has just been released. It has only a few features, but expect those to grow rapidly over the coming weeks. Follow this repo to stay up to date on the latest changes, or better yet, fork and implement some needed features (see the TODO list at the end of this README).

## Installation

Right now, specdown only support's Ruby. Next, I'll write a javascript implementation. Then, I don't know what language. Regardless, the goal is that you could use specdown with any programming language you desire.

To install the `specdown` ruby gem, simply:

    $ gem install specdown

It comes with a `specdown` command. Try running it. Doesn't matter where.

## Usage

Let's write a simple test in markdown, and execute it with specdown. Create a "specdown" directory, then save the following text into a file inside of it. I'll assume you're calling it "example.markdown":

```markdown
# Our first test!

This is our very first test. It's going to blow your mind.

    raise "WTF?" unless 1 == 1
```

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

```markdown
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
```

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

```ruby
raise "WTF?" unless 1 == 1
name = "moonmaster9000"
raise "name not in scope" if !defined? name
```

Here's what the second test looked like (#Our first test! --> ##Another Subsection)

```ruby
raise "WTF?" unless 1 == 1
raise "name in scope" if defined? name
```

## Setting up your test environment

Similar to the cucumber testing framework: If you put a ruby file somewhere inside your "specdown" directory, `specdown` will find it and load it.

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

## TODO

This library is the result of just a couple of days worth of work. It's a basic minimum viable product, but there are tons of features I want to implement. Here's what's on my immediate horizon:

* Choose which files to run
* color code the terminal output
* offer the option of outputing the actual markdown while it executes, instead of "..F....FF......"
* Better stack traces / reporting
