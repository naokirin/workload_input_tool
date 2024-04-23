# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path.
Dir.glob("packages/*/app/assets/*").each do |path|
  Rails.application.config.assets.paths << path
end

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
Rails.application.config.assets.precompile += Dir.glob("packages/*/app/assets/**/*").select do |path|
  %w(.js .css .scss .sass).include?(File.extname(path)) &&
    !File.basename(path).start_with?('_')
end.map {|p| p.gsub(/\.s?(css|js)(\.erb|)$/, '.\1').gsub(/packages\/[^\/]+\/app\/assets\/[^\/]+\//, '') }
