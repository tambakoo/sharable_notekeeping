class AccessesController < ApplicationController
  before_action :set_access, only: [:show, :update, :destroy]


  def new
    @access=Access.new
  end

  def index
    @accesses = Access.where(note_id: params[:note_id])
    @note = Note.find_by(id: params[:note_id])
  end

  def show
  end

  def create
    @access = Access.new(access_params)
      if @access.save
      redirect_to :back
    else 
      redirect_to :back, notice: "Sharing failed"
    end
  end

  def destroy
    Access.find_by(id: params[:id]).destroy
    redirect_to :back
  end

  private

  def set_access
      @access=Access.find(params[:id]) 
    end

  def access_params
    params.require(:access).permit(:note_id, :shared_to_id, :sharer_id, :level, :shareable_id, :shareable_type)
  end

end
