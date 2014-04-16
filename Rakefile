require "bundler/gem_tasks"
require "bundler/gem_helper"

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

t = Bundler::GemHelper.new

desc "Create tag #{t.send(:version_tag)}"
task :tag do
  unless t.send(:already_tagged?)
    t.send(:tag_version) do
      t.send(:perform_git_push, 'origin master')
      t.send(:perform_git_push, ' --tags origin master')
      Bundler.ui.confirm "Pushed git commits and tags."
    end
  end
end

task :default => :spec
