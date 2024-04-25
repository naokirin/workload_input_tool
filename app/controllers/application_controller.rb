# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_view_paths

  private

  def current_user_account
    User::Query::Account.from_record(super)
  end

  def set_view_paths
    prepend_view_path(Dir.glob(Rails.root.join('packages/*/app/views')))
  end
end
