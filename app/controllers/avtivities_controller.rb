class AvtivitiesController < ApplicationController
  before_action :set_avtivity, only: [:show, :update, :destroy]
  before_action :authenticate_admin!
  
  respond_to :json

  def index
    @avtivities = Avtivity.all
    respond_with(@avtivities)
  end

  def show
    respond_with(@avtivity)
  end

  def create
    @avtivity = Avtivity.new(avtivity_params)
    @avtivity.save
    respond_with(@avtivity)
  end

  def update
    @avtivity.update(avtivity_params)
    respond_with(@avtivity)
  end

  # def destroy
  #   @avtivity.destroy
  #   respond_with(@avtivity)
  # end

  private
    def set_avtivity
      @avtivity = Avtivity.find(params[:id])
    end

    def avtivity_params
      params[:avtivity]
    end
end
