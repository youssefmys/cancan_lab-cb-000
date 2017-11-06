class NotesController < ApplicationController

  before_action :authentication_required
  load_and_authorize_resource :only => [:show, :create, :update]

#  rescue_from CanCan::AccessDenied do |exception|
#    redirect_to new_session_path, flash: {:errors => 'Access denied: you are not allowed to access this page'}
#  end

  def index
    @notes = Note.all
    render :index
  end

  def show
    if @note = current_user.notes.find_by(params[:id])
      render :show
    else
      redirect_to new_sessions_path
    end
  end


  def create
     @notes = current_user.notes.create(note_params)
     redirect_to root_path
  end


  def update
      @note = current_user.notes.find(params[:id])
      @note.update(note_params)
      redirect_to root_path
  end

  private

    def note_params
      params.require(:note).permit(:content, :visible_to)
    end


end
