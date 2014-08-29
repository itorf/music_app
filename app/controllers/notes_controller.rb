class NotesController < ApplicationController
  before_action :verify_right_author, only: destroy
 
  def create
    @note = Note.create(note_params)
    @track = @note.track
    if @note.save
      flash[:notice] = "Left a note on #{@track.name}."
      redirect_to track_url(@track)
    else
      flash[:notice] = @note.errors.full_messages
      redirect_to track_url(@track)
    end
  end
  
  def destroy
    @note = Note.find(params[:id])
    @track = @note.track
    flash[:notice] = "Note deleted"
    @note.destroy
    redirect_to track_url(@track)
  end
  
  def note_params
    params.require(:note).permit(:body, :user_id, :track_id)
  end
end
