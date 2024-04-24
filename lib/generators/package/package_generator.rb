# frozen_string_literal: true

class PackageGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)

  def generate_package
    @package_name = file_name
    package_path = "packages/#{@package_name}"
    package_app_path = "#{package_path}/app"
    package_lib_path = "#{package_path}/lib"
    package_models_path = "#{package_app_path}/models/#{@package_name}"
    package_controllers_path = "#{package_app_path}/controllers/#{@package_name}"
    package_views_path = "#{package_app_path}/views/#{@package_name}"
    package_usecases_path = "#{package_app_path}/usecases/#{@package_name}"
    package_commands_path = "#{package_app_path}/commands/#{@package_name}"
    package_queries_path = "#{package_app_path}/queries/#{@package_name}"
    package_domains_path = "#{package_app_path}/domains/#{@package_name}"
    package_public_path = "#{package_app_path}/public/#{@package_name}"
    package_assets_path = "#{package_app_path}/assets"
    package_assets_stylesheets_path = "#{package_assets_path}/stylesheets"
    package_assets_javascripts_path = "#{package_assets_path}/javascripts"

    empty_directory package_path
    empty_directory package_lib_path
    empty_directory package_app_path
    empty_directory package_models_path
    empty_directory package_controllers_path
    empty_directory package_views_path
    empty_directory package_usecases_path
    empty_directory package_commands_path
    empty_directory package_queries_path
    empty_directory package_domains_path
    empty_directory package_public_path
    empty_directory package_assets_path
    empty_directory package_assets_stylesheets_path
    empty_directory package_assets_javascripts_path

    create_file "#{package_lib_path}/#{@package_name}/.keep"
    create_file "#{package_models_path}/.keep"
    create_file "#{package_controllers_path}/.keep"
    create_file "#{package_views_path}/.keep"
    create_file "#{package_usecases_path}/.keep"
    create_file "#{package_commands_path}/.keep"
    create_file "#{package_queries_path}/.keep"
    create_file "#{package_domains_path}/.keep"
    create_file "#{package_public_path}/.keep"
    create_file "#{package_assets_stylesheets_path}/.keep"
    create_file "#{package_assets_javascripts_path}/.keep"

    create_file "#{package_path}/package.yml"

    spec_lib_path = "spec/packages/#{@package_name}/lib/#{@package_name}"
    spec_models_path = "spec/packages/#{@package_name}/models/#{@package_name}"
    spec_requests_path = "spec/packages/#{@package_name}/requests/#{@package_name}"
    spec_usecases_path = "spec/packages/#{@package_name}/usecases/#{@package_name}"
    spec_commands_path = "spec/packages/#{@package_name}/commands/#{@package_name}"
    spec_queries_path = "spec/packages/#{@package_name}/queries/#{@package_name}"
    spec_domains_path = "spec/packages/#{@package_name}/domains/#{@package_name}"
    spec_public_path = "spec/packages/#{@package_name}/public/#{@package_name}"

    empty_directory spec_lib_path
    empty_directory spec_models_path
    empty_directory spec_requests_path
    empty_directory spec_usecases_path
    empty_directory spec_commands_path
    empty_directory spec_queries_path
    empty_directory spec_domains_path
    empty_directory spec_public_path

    create_file "#{spec_lib_path}/.keep"
    create_file "#{spec_models_path}/.keep"
    create_file "#{spec_requests_path}/.keep"
    create_file "#{spec_usecases_path}/.keep"
    create_file "#{spec_commands_path}/.keep"
    create_file "#{spec_queries_path}/.keep"
    create_file "#{spec_domains_path}/.keep"
    create_file "#{spec_public_path}/.keep"

    template("model_file.rb.erb", "#{package_app_path}/models/#{@package_name}.rb")
  end
end
