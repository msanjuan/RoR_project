class BizController < ApplicationController
  def index
    params[:input]
    render :action => 'index'
  end
end
