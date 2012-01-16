## CHANGELOG

## 0.3.0

NOTICE: Non-backwards compatible release.

specdown now supports github-flavored fenced codeblocks!

If you want your codeblock executed in your tests, you must explicitly
mark it as a `ruby` codeblock:

    # Example Markdown
    
    Specdown will execute the following codeblock:
    
    ```ruby
    I execute
    ```
    
    Specdown will ignore the following codeblocks:
    
    ```javascript
    console.log("hi");
    ```

        indented code block

    ```
    this code block is fenced, but not explicitly 
    tagged as ruby. therefore, specdown will not execute
    it.
    ```

## 0.2.1

Bug fix: -f command line option was broken completely. FACE RED :D

## 0.2.0

New reporting and formating options at the command line. 

    -c, --colorized                  Colorize the terminal output
    -n, --non-colorized              Display plain terminal output
    -o, --output=text|terminal       output to either the terminal or a text file "specdown_report.txt". Defaults to "terminal".
    -f, --format=short|condensed     length and style of output. Defaults to "short".

## 0.1.7

Working on all Rubies.

## 0.1.6

Command line option (-f or --format) for output format (plain|color).

Command line option (-v or --version) for specdown version.

Also, created an API for sandbox decoration. Send me your pull requests :-)

## 0.1.5

Terminal output is now colorized, by default. To turn it off, add the following to your env.rb:

    Specdown::Config.reporter = :terminal

## 0.1.4

The `specdown` command now allows you to pass off directories of tests as well as individual tests.

    specdown specdown/subdir/ specdown/test1.md specdown/subdir2/*.markdown

## 0.1.3 (2012/01/02)

The `specdown` command now accepts two options: -h and -r. 

    Usage: specdown [file|dir [file|dir [file|dir....]]]
        -r, --root SPECDOWN_DIR          defaults to ./specdown
        -h, --help                       Display this screen

## 0.1.2 (2012/01/02)

New feature added: test hooks. (see the README)

## 0.1.1 (2012/01/02)

Bug fix: better report formatting for multi-markdown test suites.

## 0.1.0 (2012/01/01)

Better Sandboxing of tests, with support for configuring the expectation/assertion framework (RSpec Expectations and Test::Unit asserstions supported)

See the "Setting up your test environment" section in the README for more information (https://github.com/moonmaster9000/specdown/blob/ccd9aea13173d582241ca39e6f4f10d50fab4490/README.markdown).

## 0.0.1 (2011/12/30)

First release! Barely passable! :-)
