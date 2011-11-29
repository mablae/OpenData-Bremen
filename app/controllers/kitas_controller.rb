class KitasController < ApplicationController
  expose(:kitas) { Kita.geocodiert.gefiltert(params).page(params[:page]).per(params[:per]) }
  expose(:kita)

  respond_to :json

  def index
    respond_with kitas
  end

  def show
    respond_with kita do |format|
      format.html { redirect_to kitas_path(anchor: kita.id) }
      format.json
    end
  end
end
