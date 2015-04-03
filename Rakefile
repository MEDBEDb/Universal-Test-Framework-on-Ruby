require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = FileList['spec/*_spec.rb']
  t.rspec_opts = '--format html > ./results.html'
end

task :default  => :spec
