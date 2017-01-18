class SynchronizationsController < ApplicationController
  def index
    @synchronizations = Synchronization.all
  end

  def show
    @synchronization = Synchronization.find(params[:id])
  end
end
