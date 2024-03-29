# encoding: utf-8
class KitasController < ApplicationController
  respond_to :json

  def index
    @kitas = Kita.geocodiert.gefiltert(params).page(params[:page]).per(params[:per])
    respond_with @kitas
  end

  def show
    @kita = Kita.find params[:id]

    respond_with @kita do |format|
      format.html { render :index }
      format.json
    end
  end
end
