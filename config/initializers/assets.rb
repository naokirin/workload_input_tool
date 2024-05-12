# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path.
Dir.glob("packages/*/app/assets/builds/*").each do |path|
  Rails.application.config.assets.paths << path
end

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
Rails.application.config.assets.precompile += Dir.glob("packages/*/app/assets/builds/**/*").select do |path|
  %w(.js).include?(File.extname(path)) &&
    !File.basename(path).start_with?('_')
end.map {|p| p.gsub(/\.s?(js)(\.erb|)$/, '.\1').gsub(/packages\/[^\/]+\/app\/assets\/[^\/]+\//, '') }

Rails.application.config.dartsass.load_paths = Dir.glob("app/assets/stylesheets/").map do |path|
  Rails.root.join(path)
end
Rails.application.config.dartsass.load_paths += Dir.glob("packages/*/app/assets/stylesheets/").map do |path|
  Rails.root.join(path)
end

Rails.application.config.dartsass.builds = Dir.glob("app/assets/stylesheets/*.scss").map do |path|
  [File.join('../../../',  path), "#{File.basename(path, '.scss')}.css"]
end.to_h
Rails.application.config.dartsass.builds.merge!(Dir.glob("packages/*/app/assets/stylesheets/*.scss").map do |path|
  package_path = path.match(/packages\/[^\/]+/)[0]
  [File.join('../../../', path), File.join(package_path, "#{File.basename(path, '.scss')}.css")]
end.to_h)

Dir.glob("packages/*/app/assets/javascripts").each do |path|
  Rails.application.config.assets.paths << Rails.root.join(path).to_s
end
