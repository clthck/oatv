require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Oatv
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.action_view.field_error_proc = ->(html_tag, instance) {
        tag = Nokogiri::HTML::DocumentFragment.parse(html_tag)
        tag.children.add_class "field-with-error parsley-error"

        unless instance.instance_of? ActionView::Helpers::Tags::Label
          field_name = tag.children[0].attribute("name").value.match(/\[(\w+)\]/)[1]
          tag.add_child "<ul class='parsley-errors-list'>" \
                          "<li class='parsley-type'>#{field_name.humanize} #{instance.error_message[0]}</li>" \
                        "</ul>"
        end
        tag.to_s.html_safe
    }

    config.action_controller.action_on_unpermitted_parameters = :raise

    Yt.configuration.api_key = ENV['OATV_YOUTUBE_API_KEY']
  end
end
