When /^I run `specdown` from the command line in a directory that contains no 'specdown' directory$/ do
  @output = `bundle exec ruby -I ./lib ./bin/specdown`
end

Then /^I should see the following output:$/ do |string|
  string.split("\n").each do |line|
    @output.include?(line.strip).should be(true)
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
