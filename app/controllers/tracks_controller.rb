class TracksController < ApplicationController
  before_action :redirect_if_not_logged_in
  
  def new
    @track = Track.new
    @album = Album.find(params[:album_id])
    @band = @album.band
    render :new
  end
  
  def create
    @track = Track.new(track_params)
    @album = @track.album
    @band = @track.band
    if @track.save
      flash[:notice] = "Created a new track for #{@album.name}: #{@track.name}"
      redirect_to album_url(@album)
    else
      flash[:notice] = @track.errors.full_messages
      render :new
    end
  end
  
  def show
    @track = Track.find(params[:id])
    render :show
  end
  
  def edit
    @track = Track.find(params[:id])
    @album = @track.album
    @band = @track.band
    render :edit
  end
  
  def update
    @track = Track.find(params[:id])
    if @track.update(track_params)
      flash[:notice] = "Updated #{@track.name}"
      redirect_to track_url(@track)
    else
      flash[:notice] = @track.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    @track = Track.find(params[:id])
    @album = @track.album
    flash[:notice] = "Deleted #{@track.name}"
    @track.destroy
    redirect_to album_url(@album)
  end
  
  def track_params
    params.require(:track).permit(:name, :album_id, :track_type, :lyrics)
  end
end
