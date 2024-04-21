# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_view_paths

  private

  def set_view_paths
    prepend_view_path(Dir.glob(Rails.root.join('packages/*/app/views')))
  end
end
