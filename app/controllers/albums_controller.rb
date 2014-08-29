class AlbumsController < ApplicationController
  before_action :redirect_if_not_logged_in
  
  def new
    @album = Album.new
    @band = Band.find(params[:band_id])
    render :new
  end
  
  def create
    @album = Album.new(album_params)
    @band = @album.band
    
    if @album.save
      flash[:notice] = "Added #{@album.name} to #{@band.name}'s albums."
      redirect_to album_url(@album)
    else
      flash[:notice] = @album.errors.full_messages
      render :new
    end
  end
  
  
  def show
    @album = Album.find(params[:id])
    render :show
  end
  
  def edit
    @album = Album.find(params[:id])
    @band = @album.band
    render :edit
  end
  
  def update
    @album = Album.find(params[:id])
    if @album.update(album_params)
      flash[:notice] = "Updated #{@album.name}."
      redirect_to album_url(@album)
    else
      flash[:notice] = @album.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    @album = Album.find(params[:id])
    @band = @album.band
    flash[:notice] = "Deleted #{@album.name}"
    @album.destroy
    redirect_to band_url(@band)
  end
  
  def album_params
    params.require(:album).permit(:name, :band_id, :album_type)
  end
end
