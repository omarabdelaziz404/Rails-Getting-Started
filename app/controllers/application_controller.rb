class ApplicationController < ActionController::Base
  include Authentication
  allow_browser versions: :modern # Only allow modern browsers supporting webp images,import maps, and CSS.
  stale_when_importmap_changes # Changes to the importmap will invalidate the etag for HTML responses
  around_action :switch_locale

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end
end
