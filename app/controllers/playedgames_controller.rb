class PlayedgamesController < ApplicationController
  before_action :set_playedgame, only: [:show, :edit, :update, :destroy]

  # GET /playedgames
  # GET /playedgames.json
  def index
    @playedgames = Playedgame.all
  end

  # GET /playedgames/1
  # GET /playedgames/1.json
  def show
  end

  # GET /playedgames/new
  def new
    @playedgame = Playedgame.new
  end

  # GET /playedgames/1/edit
  def edit
  end

  # POST /playedgames
  # POST /playedgames.json
  def create
    @playedgame = Playedgame.new(playedgame_params)

    respond_to do |format|
      if @playedgame.save
        format.html { redirect_to @playedgame, notice: 'Playedgame was successfully created.' }
        format.json { render :show, status: :created, location: @playedgame }
      else
        format.html { render :new }
        format.json { render json: @playedgame.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /playedgames/1
  # PATCH/PUT /playedgames/1.json
  def update
    respond_to do |format|
      if @playedgame.update(playedgame_params)
        format.html { redirect_to @playedgame, notice: 'Playedgame was successfully updated.' }
        format.json { render :show, status: :ok, location: @playedgame }
      else
        format.html { render :edit }
        format.json { render json: @playedgame.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /playedgames/1
  # DELETE /playedgames/1.json
  def destroy
    @playedgame.destroy
    respond_to do |format|
      format.html { redirect_to playedgames_url, notice: 'Playedgame was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_playedgame
      @playedgame = Playedgame.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def playedgame_params
      params.require(:playedgame).permit(:player_id, :game_id, :playedtime)
    end
end
