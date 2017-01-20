class ConnectorConfigurationsController < ApplicationController
  include ActionController::MimeResponds

  def index
    @connections = ConnectorConfiguration.all
    
    respond_to do |format|
      format.html
      format.jsonapi { render jsonapi: @connections }
    end
  end
end
