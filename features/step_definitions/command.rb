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
  @output = bundle_exec! "specdown"
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
  @output = bundle_exec! command
end

Then /^I should not see colorized output$/ do
  ensure_plain! @output
end

Then /^I should see colorized output$/ do
  ensure_colorized! @output
end

Given /^The following commands should yield colorized output:$/ do
end

Given /^`specdown \-c`$/ do
  ensure_colorized! bundle_exec!("specdown -c")
end

Given /^`specdown \-\-colorized`$/ do
  ensure_colorized! bundle_exec!("specdown --colorized")
end

Given /^The following commands should yield non\-colorized output:$/ do
end

Given /^`specdown \-n`$/ do
  ensure_plain! bundle_exec!("specdown -n")
end

Given /^`specdown \-\-non\-colorized`$/ do
  ensure_plain! bundle_exec!("specdown --non-colorized")
end

Given /^The following commands should output reports to a text file, 'specdown_report\.txt':$/ do
end

Given /^`specdown \-o text`$/ do
  ensure_text! "specdown -o text"
end

Given /^`specdown \-\-output=text`$/ do
  ensure_text! "specdown --output=text"
end

Given /^The following commands should output reports to STDOUT:$/ do
end

Given /^`specdown \-o terminal`$/ do
  ensure_colorized! bundle_exec!("specdown -o terminal")
end

Given /^`specdown \-\-output=terminal`$/ do
  ensure_colorized! bundle_exec!("specdown --output=terminal")
end

Given /^The following commands should output only the most basic summary information to STDOUT:$/ do
end

Given /^`specdown \-f short`$/ do
  ensure_short! bundle_exec!("specdown -f short")
end

Given /^`specdown \-\-format=short`$/ do
  ensure_short! bundle_exec!("specdown --format=short")
end

Given /^The following commands should output summary information for each file run to STDOUT:$/ do
end

Given /^`specdown \-f condensed`$/ do
  ensure_condensed! bundle_exec!("specdown -f condensed")
end

Given /^`specdown \-\-format=condensed`$/ do
  ensure_condensed! bundle_exec!("specdown --format=condensed")
end

def ensure_condensed!(output)
  output.strip.should_not be_empty
  output.should match(/^[^\. ]+\.markdown: .*$/)
end

def ensure_short!(output)
  output.strip.should_not be_empty
  output.should_not match(/^[^\. ]+\.markdown: .*$/)
end

def ensure_text!(command)
  output = bundle_exec! command
  file_name = File.join directory, "specdown_report.txt"
  proc { File.read(file_name) }.should_not raise_exception
  File.delete(file_name)
end

def ensure_colorized!(output)
  raise "Oops! Output is not colorized!" unless colorized?(output)
end

def ensure_plain!(output)
  raise "Oops! Output is colorized!" if colorized?(output)
end

def colorized?(output)
  output.include? "\e[1m"
end

def bundle_exec(command)
  "cd #{directory} && bundle exec ruby -I ../../../lib ../../../bin/#{command}"
end

def bundle_exec!(command)
  `#{bundle_exec(command)}`
end

def directory
  @directory ||= "features/specdown_examples/no_ruby/"
end
