Gem::Specification.new do |s|
  s.name      = "specdown"
  s.author    = "Matt Parker"
  s.email     = "moonmaster9000@gmail.com"
  s.summary   = "Write your specs as if they were a README, then EXECUTE them."
  s.homepage  = "http://github.com/moonmaster9000/specdown"
  s.version   = File.read "VERSION"

  s.add_development_dependency "cucumber"
  s.add_development_dependency "rspec"

  s.add_dependency "kramdown", "~> 0.13.4"
end
