Given /^a `Specdown::Test` instance:$/ do |string|
  eval string
  @test.code.should be_empty
end

Then /^I should be able to add code to it:$/ do |string|
  eval string
  @test.code.should_not be_empty
end

Given /^a `Specdown::Test` instance `@test`$/ do
  @test = Specdown::Test.new
end

Then /^I should be able to add undefined implicits to it:$/ do |string|
  @test.undefined_implicits.should be_empty
  eval string
  @test.undefined_implicits.should_not be_empty
end

Given /^a `Specdown::Test` instance `@test` with undefined implicits$/ do
  @test = Specdown::Test.new
  @test.undefined_implicits << "1"
end

When /^I execute the test:$/ do |string|
  eval string
end

Then /^`@test\.status` should be :([^\ ]*)$/ do |status|
  @test.status.should == status.to_sym
end

When /^I execute it, the test status should be:$/ do
end

Given /^:passing   if it doesn't throw any exceptions and has no undefined implicits$/ do
  @test = generate_test(:passing)
  @test.execute
  @test.status.should == :passing
end

Given /^:undefined if it has any undefined implicits$/ do
  @test = generate_test(:undefined)
  @test.execute
  @test.status.should == :undefined
end

Given /^:pending   if it throws a `Specdown::Pending` exception$/ do
  @test = generate_test(:pending)
  @test.execute
  @test.status.should == :pending
end

Given /^:failing   if it throws an exception other than `Specdown::Pending`$/ do
  @test = generate_test(:failing)
  @test.execute
  @test.status.should == :failing
end

Given /^If your test throws an exception, you can access it via the `exception` method$/ do
  @test = generate_test :failing
  @test.exception.should be(nil)
  @test.execute
  @test.exception.should_not be(nil)
end

Given /^The `Specdown::Test\.before_execute` method allows you to add code that runs before every test:$/ do |string|
  before = false
  Specdown::Test.before_execute do
    before = true
  end

  Specdown::Test.new.execute
  before.should be(true)
end

Given /^The `Specdown::Test\.after_execute` method allows you to add code that runs after every test:$/ do |string|
  after = false
  Specdown::Test.after_execute do
    after = true
  end

  Specdown::Test.new.execute
  after.should be(true)
end

Given /^The `Specdown::Test\.around_execute` method allows you to add code that runs around every test:$/ do |string|
  around = nil
  Specdown::Test.around_execute do
    if around
      around = false
    else
      around = true
    end
  end

  Specdown::Test.new.execute
  around.should be(false)
end

Given /^You can remove all `Specdown::Test` callbacks by calling `Specdown::Test\.remove_callbacks!`$/ do
  Specdown::Test.before_execute do |test|
    puts "I'm a callback!"
  end

  Specdown::Test.before_hooks["execute"].should_not be_empty

  Specdown::Test.remove_callbacks!

  Specdown::Test.before_hooks["execute"].should be_empty
end

def generate_test(status)
  @test = Specdown::Test.new

  case status
    when :passing 
      @test.code << "1"
    when :failing
      @test.code << "raise 'exception!'"
    when :undefined
      @test.undefined_implicits << "undefined implicit!"
    when :pending
      @test.code << "pending"
  end

  @test
end
