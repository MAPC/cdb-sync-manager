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

  def sync_now
    Synchronization.find(params[:id]).sync_now
    @synchronization = Synchronization.find(params[:id])
    render jsonapi: @synchronization
  end
end
