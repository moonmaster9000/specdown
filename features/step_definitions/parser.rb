Given /^the following specdown example file containing non\-executing codeblocks:$/ do |string|
  @readme = File.read "features/fixtures/non_executing_example.markdown"
end

Given /^the following specdown example file:$/ do |string|
  @readme = File.read "features/fixtures/parser_example.markdown"
end

Given /^the following specdown example file containing multiple executable codeblocks in a single section:$/ do |string|
  @readme = File.read "features/fixtures/multiple_codeblocks_per_section_example.markdown"
end

When /^I parse it into a tree:$/ do |string|
  eval string
end

Then /^the root should be the ".*" section:$/ do |string|
  eval string
end

Then /^the root should have two children:$/ do |string|
  eval string
end

Then /^the first leaf should contain only the explicit ruby code:$/ do |string|
  eval string
end

Then /^the second leaf should not contain any executable code:$/ do |string|
  eval string
end

Then /^the code blocks should be joined together with newlines:$/ do |string|
  eval string
end
