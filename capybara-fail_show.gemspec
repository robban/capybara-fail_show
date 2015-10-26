Gem::Specification.new do |s|
  s.name        = 'capybara-fail_show'
  s.version     = '0.1.0'
  s.date        = '2015-10-26'
  s.summary     = "Show capybara feature fails in the browser"
  s.description = "When a feature fails, the browser opens the page where the test failed and shows the error."
  s.authors     = ["Robert Johansson"]
  s.email       = 'robert@competic.se'
  s.files       = ["lib/capybara/fail_show.rb"]
  s.license       = 'MIT'

  s.add_runtime_dependency 'launchy'
  s.add_runtime_dependency 'rspec-rails' # But sort of needs to be called from the spec helper so hard to avoid it
  s.add_runtime_dependency 'capybara'
end
