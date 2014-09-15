require 'test_helper'

class PlayedgamesControllerTest < ActionController::TestCase
  setup do
    @playedgame = playedgames(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:playedgames)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create playedgame" do
    assert_difference('Playedgame.count') do
      post :create, playedgame: { game_id: @playedgame.game_id, playedtime: @playedgame.playedtime, player_id: @playedgame.player_id }
    end

    assert_redirected_to playedgame_path(assigns(:playedgame))
  end

  test "should show playedgame" do
    get :show, id: @playedgame
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @playedgame
    assert_response :success
  end
  test "should update playedgame" do
    patch :update, id: @playedgame, playedgame: { game_id: @playedgame.game_id, playedtime: @playedgame.playedtime, player_id: @playedgame.player_id }
    assert_redirected_to playedgame_path(assigns(:playedgame))
  end

    test "should destroy playedgame" do
      assert_difference('Playedgame.count', -1) do
        delete :destroy, id: @playedgame
      end

      assert_redirected_to playedgames_path
    end
end
