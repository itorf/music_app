class BandsController < ApplicationController
  before_action :redirect_if_not_logged_in
  
  def index
    @bands = Band.all
    render :index
  end

  def new
    @band = Band.new
    render :new
  end
  
  def create
    @band = Band.new(band_params)
    
    if @band.save
      flash[:notice] = "You created the band #{@band.name.capitalize}!"
      redirect_to bands_url
    else
      flash[:notice] = @band.errors.full_messages
      render :new
    end
  end
  
  def show
    @band = Band.find(params[:id])
    render :show
  end
  
  def edit
    @band = Band.find(params[:id])
    render :edit
  end
  
  def update
    @band = Band.find(params[:id])
    if @band.update(band_params)
      flash[:notice] = "Successfully edited #{@band.name}'s info."
      redirect_to band_url
    else
      flash[:notice] = @bands.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    @band = Band.find(params[:id])
    flash[:notice] = "Deleted the band #{@band.name}"
    @band.destroy
    redirect_to bands_url
  end
  
  def band_params
    params.require(:band).permit(:name)
  end
end
