class IndexController < ApplicationController
  def show
    @result = Analize.find params[:result] if params[:result]
  end

  def search
    operation = ::Nlu.new(params[:request])
    @result = operation.call
    redirect_to index_show_path(result: @result),
                flash: { error: operation.errors.join(', ') }
  end
end
