class IndexController < ApplicationController
  def show
    @result = Analize.find params[:result] if params[:result]
  end

  def search
    @result = ::Nlu.new(params[:request]).call
    redirect_to index_show_path(result: @result.id)
  end
end
