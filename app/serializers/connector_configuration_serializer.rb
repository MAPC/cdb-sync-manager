class ConnectorConfigurationSerializer < ActiveModel::Serializer
  attributes :id, :database, :get_table_names
end
