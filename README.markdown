# specdown

[![Build Status](https://secure.travis-ci.org/moonmaster9000/specdown.png)](http://travis-ci.org/moonmaster9000/specdown)

Write your README in markdown, and execute it with specdown. 

## Why?

When you write a README for a library, a class, a command, etc., you're
forced to stop and consider your user:

* how are they going to use it?
* what's the API
* how am I going to convince them to use my library?

What if you write the README first, before writing your code? This is the
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

## Usage

Let's write a simple test in ([github-flavored](http://github.github.com/github-flavored-markdown/)) markdown, and execute it with specdown. Create a "specdown" directory, then save the following text into a file inside of it. I'll assume you're calling it "example.markdown":

    # Our first test!

    This is our very first test. It's going to blow your mind.

    ```ruby
    raise "WTF?" unless 1 == 1
    ```

Ok, if you've been following along, then `ls -R` should return the following directory structure:

```sh
$ ls -R
  
  specdown/
    example.markdown
```

Great. Now run the `specdown` command:

```sh
    $ specdown

        .

        1 markdown
        1 test
        1 success
        0 failures
```

Booya!

### How does it work?

`specdown` loads any "markdown" files it can find inside the "specdown" directory, parses them into trees, then performs exhaustive depth-first searches on the trees to execute the code.

Let's update our README to help illustrate this:

    # Our first test!

    This is our very first test. It's going to blow your mind.
    
    ```ruby
    raise "WTF?" unless 1 == 1
    ```

    ## A Subsection

    In this section, we're going to create a variable.

    ```ruby
    name = "moonmaster9000"
    ```

    ### A sub subsection

    In this subsection, we have access to anything created or within scope in parent sections:

    ```ruby
    raise "name not in scope" if !defined? name
    ```

    ## Another Subsection

    In this subsection, we don't have access to the "name" variable. Think of your markdown as a tree.
    
    ```ruby
    raise "name in scope" if defined? name
    ```

Read through that. I'm giving you some important scoping hints in it. 

Save it, run it.

```sh
$ specdown

    ..
    
    1 markdown
    2 tests
    0 failures
```

Notice how the headers in your markdown form a tree?

```sh
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
```

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

## Non-executable code blocks

As of version `0.3.0`, you must surround any codeblocks you
want specdown to execute with a github-flavored backtick fence. This
change is not backwards-compatible with previous versions; you'll need
to update your tests if you want to upgrade to this version.

I made this change because it's likely that in the process of writing your 
specdown, you'll want to add some code into your markdown that you don't want executed.
Perhaps it's code in a different language, or perhaps you're showing off
some command line functionality.

Specdown only executes fenced codeblocks specifically flagged as `ruby`.
Thus, if you want to add some code to your markdown that shouldn't be
executed, then just don't specifically flag it as Ruby:

    # Non-Executable Code Blocks
    
    Here's an example of a non-executing code block:
    
        $ cd /
    
    Here's another example of a non-executing code block:
        
    ```javascript
    console.log("I'm javascript, so I won't execute.");
    ```

    A third example:
    
    ```
    I'm not flagged as anything, so I won't execute.
    ```

    ## Executable codeblocks
    
    The only way to make a code block execute is to specifically flag it as Ruby
    
    ```ruby
    puts "I execute!"
    ```

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

Currently, we offer two report formats: short, or condensed. Short
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
Specdown::Config.format = :condensed
```

The default is `:short`.

## TODO

This library is quite new, but I am rapidly adding features to it. Here's what is on the immediate horizon:

* allow flagged text in the markdown to execute code, like a cucumber step definition
* offer the option of outputing the actual markdown while it executes, instead of "..F....FF......"
* Better stack traces / reporting

## LICENSE

This software is [public domain](http://en.wikipedia.org/wiki/Public_domain). GO WILD
