class Synchronization
  include Her::Model

  def self.connectors
    all.select { |synchronization| synchronization.service_name == 'connector' }
  end

  def sync_now
    Synchronization.put("synchronizations/#{id}/sync_now")
  end

  # only chainable from "connectors" because 
  # of some limitations in Her gem/API
  def connector_config
    JSON.parse(service_item_id)
  end

  def database
    connector_config["connection"]["database"]
  end

  def table_name
    connector_config["table"]
  end

  def schema
    connector_config["schema"]
  end
end
