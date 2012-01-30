Given /^the following readme:$/ do |string|
  eval string
end

When /^I run the tests in the readme:$/ do |string|
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

Then /^`Specdown::Reporter\.new\.summary\(@readme\)` should return a report summary object:$/ do |string|
  eval string
end

Then /^the generic reporter shouldn't actually print anything:$/ do |string|
  eval string
end
