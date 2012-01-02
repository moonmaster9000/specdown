Specdown::EventServer.register :command_complete do |results|
  puts "\n\n" 
  puts Specdown::Report.new(results).generate
end
