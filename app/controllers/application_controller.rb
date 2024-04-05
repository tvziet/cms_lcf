# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_employee!

  protected

  def after_sign_out_path_for(_resource_or_scope)
    root_path
  end
end
