# frozen_string_literal: true

class ApplicationController < ActionController::Base
  add_flash_types :error
  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  after_action :ajax_flash_to_headers

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  #  The following lines are useful when developping Pundit policies
  # after_action :verify_authorized, except: %i[index show], unless: %i[active_admin_controller? devise_controller?]
  # after_action :verify_policy_scoped, only: :index, unless: :active_admin_controller?

  protected

  def configure_permitted_parameters
    added_attrs = %i[first_name biography last_name phone_number email password password_confirmation remember_me avatar]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :accept_invitation, keys: [:first_name, :last_name]
  end

  def active_admin_controller?
    is_a?(ActiveAdmin::BaseController)
  end

  def pundit_user
    current_member
  end

  private

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    flash[:error] = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
    redirect_to root_path
  end

  def after_sign_in_path_for(resource)
    thredded_path || super
  end

  def after_invite_path_for(_inviter, _invitee)
    new_member_invitation_path
  end

  def set_locale
    I18n.locale = :fr
  end

  def ajax_flash_to_headers
    return unless request.xhr?

    flash_type, flash_message = extract_flash
    response.headers['Flash-message'] = flash_message
    response.headers['Flash-message-type'] = flash_type

    flash.discard
  end

  def extract_flash
    flash.each do |type, msg|
      return [type, msg] unless flash[type].blank?
    end
  end
end
