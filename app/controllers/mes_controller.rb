class MesController < ApplicationController
  def show
    @me = Account.find(params[:id])
  end
end
