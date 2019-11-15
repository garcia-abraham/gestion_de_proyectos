class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Devise::Controllers::Helpers

  private

  def admin_user
    redirect_to(root_path) unless current_user && current_user.adm?
  end



end
