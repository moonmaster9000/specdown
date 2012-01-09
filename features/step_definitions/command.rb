When /^I run `specdown` from the command line in a directory that contains no 'specdown' directory$/ do
  @output = `bundle exec ruby -I ./lib ./bin/specdown`
end

Then /^I should see the following output:$/ do |string|
  string.split("\n").each do |line|
    @output.should include(line.strip)
  end
end

Given /^I have a specdown directory containing a (?:single )?markdown file:$/ do |string|
  @directory = "features/specdown_examples/no_ruby/"
end

When /^I run `specdown` with no arguments$/ do
  @output = `cd #{@directory} && bundle exec ruby -I ../../../lib ../../../bin/specdown`
end

Given /^a single ruby file:$/ do |string|
  @directory = "features/specdown_examples/with_ruby/"
end

Given /^I have a specdown directory 'specdown\/tests' containing 3 markdown files, each with 1 passing test$/ do
  @directory = "features/specdown_examples/nested_directories_test/"
end

Given /^I am in a directory with a 'specdown' folder$/ do
  @directory = "features/specdown_examples/format_switch_test/"
end

When /^I run `(.*)`$/ do |command|
  @output = `cd #{@directory} && bundle exec ruby -I ../../../lib ../../../bin/#{command}`
end

Then /^I should not see colorized output$/ do
  raise "Oops! Output is colorized!" if colorized?(@output)
end

Then /^I should see colorized output$/ do
  raise "Oops! Output is not colorized!" unless colorized?(@output)
end

def colorized?(output)
  output.include? "\e[1m"
end
