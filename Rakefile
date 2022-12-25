# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task default: :spec

task :generate_rbs do
  sh "sord sig/defs.rbs"
  sh %q{sed -i$([ $(uname) = "Darwin" ] && echo ' ""') '1s/^/# This file was generated by "rake generate_rbs"\n/' sig/defs.rbs}
end
