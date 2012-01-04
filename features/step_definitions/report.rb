Given /^the following runner:$/ do |string|
  eval string
end

When /^I run the tests in the runner:$/ do |string|
  eval string
end

Then /^`(.*)` should include the following output:$/ do |code, string|
  output = eval code
  string.split("\n").each do |line|
    output.should include(line.strip)
  end
end

Given /^the following of Specdown::Stats instances:$/ do |string|
  eval string
end
