Given /^a specdown directory with a markdown file with TWO tests$/ do
end

Given /^an environment file with the following before hook:$/ do |string|
  @directory = "features/specdown_examples/before_hooks"
end

When /^I run the specdown command for that directory$/ do
  @output = `cd #{@directory} && bundle exec ruby -I ../../../lib ../../../bin/specdown`
end

Then /^I should see the following output (\d+) times?:$/ do |n, string|
  @output.split("\n").select {|line| line.strip =~ /#{string.strip}/}.count.should == n.to_i
end

Given /^a specdown directory with a markdown file with THREE tests$/ do
end

Given /^an environment file with the following after hook:$/ do |string|
  @directory = "features/specdown_examples/after_hooks"
end

Given /^a specdown directory with a markdown file with ONE test$/ do
end

Given /^an environment file with the following around hook:$/ do |string|
  @directory = "features/specdown_examples/around_hooks"
end

Given /^a specdown directory containing markdown files named ".*" each containing a single test$/ do
  @directory = "features/specdown_examples/scoped_hooks"
end

Given /^an environment file with the following hooks:$/ do |string|
end
