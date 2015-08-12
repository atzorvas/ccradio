class StreamsController < ApplicationController
  before_action :set_stream, only: [:show, :edit, :update, :destroy, :playlist, :current_song]
  before_action :authenticate_admin, :except => [:show, :index, :playlist, :current_song]

  # GET /streams
  # GET /streams.json
  def index
    @streams = Stream.all
  end

  # GET /streams/1
  # GET /streams/1.json
  def show
  end

  # GET /streams/new
  def new
    @stream = Stream.new
  end

  # GET /streams/1/edit
  def edit
  end

  # POST /streams
  # POST /streams.json
  def create
    @stream = Stream.new(stream_params)

    respond_to do |format|
      if @stream.save
        format.html { redirect_to @stream, notice: 'Stream was successfully created.' }
        format.json { render :show, status: :created, location: @stream }
      else
        format.html { render :new }
        format.json { render json: @stream.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /streams/1
  # PATCH/PUT /streams/1.json
  def update
    respond_to do |format|
      if @stream.update(stream_params)
        format.html { redirect_to @stream, notice: 'Stream was successfully updated.' }
        format.json { render :show, status: :ok, location: @stream }
      else
        format.html { render :edit }
        format.json { render json: @stream.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /streams/1
  # DELETE /streams/1.json
  def destroy
    @stream.destroy
    respond_to do |format|
      format.html { redirect_to streams_url, notice: 'Stream was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def playlist
    respond_to do |format|
      format.json {
        render :json => {
          genre: @stream.title,
          url: @stream.url_play,
          history: @stream.playlist_items.order("created_at DESC")
        }
      }
      format.html { redirect_to @stream }
    end
  end

  def current_song
    item = @stream.playlist_items.last
    respond_to do |format|
      format.json { render :json => { song: item.song, created_at: item.created_at } if song }
      format.html { redirect_to @stream }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_stream
    @stream = Stream.find(params[:id] || params[:stream_id])
  end

  # Never trust parameters from the scary internet.
  def stream_params
    params.require(:stream).permit(:title, :server, :mount)
  end
end
