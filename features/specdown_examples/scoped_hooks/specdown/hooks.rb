puts "hooks loading!"
Specdown.around /fun/ do
  puts "I run before and after fun tests."
end

Specdown.before "spec3.markdown" do
  puts "I run before tests in spec3"
end

Specdown.after "spec1.fun.markdown", /spec3/ do
  puts "I run after tests in spec1 and spec3."
end
