class SynchronizationsController < ApplicationController
  def index
    @synchronizations = Synchronization.connectors
  end

  def show
    @synchronization = Synchronization.find(params[:id])
  end

  def sync_now
    Synchronization.find(params[:id]).sync_now
    redirect_to request.referrer
  end
end
