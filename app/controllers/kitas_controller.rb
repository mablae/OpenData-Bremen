class KitasController < ApplicationController
  expose(:kitas) { Kita.geocodiert.page(params[:page]).per(params[:per]) }
  expose(:kita)

  respond_to :json

  caches_page :index

  def index
    respond_with kitas
  end

  def show
    respond_with kita
  end
end
