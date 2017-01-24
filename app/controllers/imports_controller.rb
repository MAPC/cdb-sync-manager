class ImportsController < ApplicationController
  include ActionController::MimeResponds

  def index
    @imports = Import.all
    
    respond_to do |format|
      format.html
      format.jsonapi { render jsonapi: @imports }
    end
  end
end
