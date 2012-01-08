## CHANGELOG

## 0.1.5

Terminal output is now colorized, by default. To turn it off, add the following to your env.rb:

    Specdown::Config.reporter = :terminal

## 0.1.4

The `specdown` command now allows you to pass off directories of tests as well as individual tests.

    specdown specdown/subdir/ specdown/test1.md specdown/subdir2/*.markdown

## 0.1.3 (2012/01/02)

The `specdown` command now accepts two options: -h and -r. 

    Usage: specdown [file1 [file2 [file3....]]]
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
