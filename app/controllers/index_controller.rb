class IndexController < ApplicationController
  def show
    @result = SiteDatum.order(:rank)
  end

  def search
    operation = ::Nlu.new(params[:request])
    operation.call
    redirect_to index_show_path, flash: { error: operation.errors.join(', ') }
  end
end
