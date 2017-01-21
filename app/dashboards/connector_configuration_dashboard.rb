require "administrate/base_dashboard"

class ConnectorConfigurationDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    provider: Field::String,
    server: Field::String,
    database: Field::String,
    username: Field::String,
    password: Field::String,
    interval: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :provider,
    :server,
    :database,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :provider,
    :server,
    :database,
    :interval,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :provider,
    :server,
    :database,
    :username,
    :password,
    :interval,
  ].freeze

  # Overwrite this method to customize how connector configurations are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(connector_configuration)
  #   "ConnectorConfiguration ##{connector_configuration.id}"
  # end
end
