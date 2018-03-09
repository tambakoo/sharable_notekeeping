class NotesController < ApplicationController

  before_action :set_note, only: [:show, :edit, :update, :destroy]

  # def index
  #   if params[:tag] 
  #     @notes= Note.tagged_with(params[:tag])
  #   else
  #     @notes = Note.all.order(created_at: :desc)
  #   end
  # end

  def index
      @notes = Note.owner(current_user)
  end

  def shared
    @notes=Note.shared(current_user)
    render 'index'
  end

  def show
  end

  def new
    @note = current_user.notes.new
  end

  def edit
  end

  def create
    @note = current_user.notes.new(note_params)

    respond_to do |format|
      if @note.save
        format.html { redirect_to @note }
        format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to @note }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url, notice: 'Note destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_note
      @note = Note.find(params[:id])
    end

    def note_params
      params.require(:note).permit(:title, :body, :all_tags)
    end
end
