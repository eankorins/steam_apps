class PlayersController < ApplicationController

  require 'will_paginate/array'
  include PlayersHelper

  before_action :set_player, only: [:show, :edit, :update, :get_friends, :destroy]
  
  
    # GET /players"
  # GET /players.json
  def index
    @players = Player.all.sort_by(&:total_time).reverse.paginate(:page => params[:page], :per_page => 100)
  end

  # GET /players/1
  # GET /players/1.json
  def show
    puts "#{@player.updated_at}      <    #{10.minutes.ago.utc}"
    if @player.updated_at < 24.hours.ago.utc
      @player.get_profile
    end
    @friendships = @player.friendships.paginate(:page => params[:page], :per_page => 30)
    sortedgames = @player.playedgames.by_time_played.paginate(:page => params[:page], :per_page => 30)
    @playedgames = sortedgames
    @match_participations = @player.participations.sort_by{ |x|x.match.start_time }.reverse.paginate(:page => params[:part_page], :per_page => 30)
  end

  # GET /players/new
  def new
    @player = Player.new
  end

  # GET /players/1/edit
  def edit
  end
  # POST /players
  # POST /players.json
  def create
    id = player_params[:account_id].to_i - 76561197960265728
    @player = Player.new(:account_id => id)

    respond_to do |format|
      if @player.save
        format.html { redirect_to @player, notice: 'Player was successfully created.' }
        format.json { render :show, status: :created, location: @player }
      else
        format.html { render :new }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { render :show, status: :ok, location: @player }
      else
        format.html { render :edit }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end
  def get_friends
    @player.get_friends
    redirect_to action: 'show'
  end
  def get_matches
    MatchWorker.perform_async(params[:id])
    redirect_to action: 'show'
  end
  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @player.destroy
    respond_to do |format|
      format.html { redirect_to players_url, notice: 'Player was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id].to_s)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:account_id)
    end
end
