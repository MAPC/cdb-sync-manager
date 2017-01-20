class CreateConnectorConfigurations < ActiveRecord::Migration
  def change
    create_table :connector_configurations do |t|
      t.string :provider
      t.string :server
      t.string :database
      t.string :username
      t.string :password
      t.string :table
      t.string :schema
      t.string :interval

      t.timestamps null: false
    end
  end
end
