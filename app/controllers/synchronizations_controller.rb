class SynchronizationsController < ApplicationController
  include ActionController::MimeResponds

  def index
    @synchronizations = Synchronization.connectors
    
    respond_to do |format|
      format.html
      format.jsonapi { render jsonapi: @synchronizations }
    end
  end

  def show
    @synchronization = Synchronization.find(params[:id])
    respond_to do |format|
      format.html
      format.jsonapi { render jsonapi: @synchronization }
    end
  end

  def create
    connector = ConnectorConfiguration.find(post_params[:connection_id])
    json = JSON.parse(post_params[:service_item_id])
    config = 
      { "connector": 
        { "provider": "postgres", 
          "connection": { "server": connector.server, 
                          "database": connector.database, 
                          "username": connector.username, 
                          "password": connector.password }, 
          "table": json["table"], 
          "schema": json["schema"] }, 
        "interval": 15778463 }
    sync = Synchronization.post("synchronizations", config)
    puts sync
    respond_to do |format|
      format.html
      format.jsonapi { render jsonapi: sync }
    end
  end

  def destroy
    @synchronization = Synchronization.find(params[:id])
    @synchronization.destroy
  end

  def sync_now
    Synchronization.find(params[:id]).sync_now
    @synchronization = Synchronization.find(params[:id])
    render jsonapi: @synchronization
  end

  def post_params
    ActiveModelSerializers::Deserialization.jsonapi_parse!(params, only: [:connection_id, :service_item_id] )
  end
end
