task :before_assets_precompile do
  # run the typescript compiler
  system('npm run tsc')
end

# every time you execute 'rake assets:precompile'
# run 'before_assets_precompile' first
Rake::Task['assets:precompile'].enhance(['before_assets_precompile'])
