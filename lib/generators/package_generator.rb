# frozen_string_literal: true

require 'rails/generators'

class PackageGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('package/templates', __dir__)

  def generate_package # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    @package_name = file_name
    package_path = "packages/#{@package_name}"
    package_app_path = "#{package_path}/app"
    package_lib_path = "#{package_path}/lib"
    package_models_path = "#{package_app_path}/models/#{@package_name}"
    package_controllers_path = "#{package_app_path}/controllers/#{@package_name}"
    package_views_path = "#{package_app_path}/views/#{@package_name}"
    package_usecases_path = "#{package_app_path}/usecases/#{@package_name}"
    package_domains_path = "#{package_app_path}/domains/#{@package_name}"
    package_repositories_path = "#{package_app_path}/repositories/#{@package_name}"
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
    empty_directory package_domains_path
    empty_directory package_repositories_path
    empty_directory package_public_path
    empty_directory package_assets_path
    empty_directory package_assets_stylesheets_path
    empty_directory package_assets_javascripts_path

    create_file "#{package_lib_path}/#{@package_name}/.keep"
    create_file "#{package_models_path}/.keep"
    create_file "#{package_controllers_path}/.keep"
    create_file "#{package_views_path}/.keep"
    create_file "#{package_usecases_path}/.keep"
    create_file "#{package_domains_path}/.keep"
    create_file "#{package_repositories_path}/.keep"
    create_file "#{package_public_path}/.keep"
    create_file "#{package_assets_stylesheets_path}/.keep"
    create_file "#{package_assets_javascripts_path}/.keep"
    copy_file 'package.yml', "#{package_path}/package.yml"

    spec_lib_path = "packages/#{@package_name}/spec/lib/#{@package_name}"
    spec_models_path = "packages/#{@package_name}/spec/models/#{@package_name}"
    spec_requests_path = "packages/#{@package_name}/spec/requests/#{@package_name}"
    spec_usecases_path = "packages/#{@package_name}/spec/usecases/#{@package_name}"
    spec_domains_path = "packages/#{@package_name}/spec/domains/#{@package_name}"
    spec_repositories_path = "packages/#{@package_name}/spec/repositories/#{@package_name}"
    spec_public_path = "packages/#{@package_name}/spec/public/#{@package_name}"
    spec_factories_path = "packages/#{@package_name}/spec/factories/#{@package_name}"

    empty_directory spec_lib_path
    empty_directory spec_models_path
    empty_directory spec_requests_path
    empty_directory spec_usecases_path
    empty_directory spec_domains_path
    empty_directory spec_repositories_path
    empty_directory spec_public_path
    empty_directory spec_factories_path

    create_file "#{spec_lib_path}/.keep"
    create_file "#{spec_models_path}/.keep"
    create_file "#{spec_requests_path}/.keep"
    create_file "#{spec_usecases_path}/.keep"
    create_file "#{spec_domains_path}/.keep"
    create_file "#{spec_repositories_path}/.keep"
    create_file "#{spec_public_path}/.keep"
    create_file "#{spec_factories_path}/.keep"
  end
end
