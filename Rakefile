begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
end

task default: %w[spec]

task :test do
  ruby "interface.rb"
end
