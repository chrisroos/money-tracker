Rake::Task[:default].clear

task default: [:rubocop, :test, :cucumber]
