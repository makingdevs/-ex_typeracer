defmodule KeyboardHeroes.Room do

  alias KeyboardHeroes.Logic.Game

  def start(%Game{} = game) do
    spawn KeyboardHeroes.Room, :handle, [game]
  end

  def add_player(game_server, username) do
    send game_server, { self(), :add_player, username }
  end

  def handle(%Game{} = game) do
    receive do
      {pid, :add_player, username} ->
        game_updated = Game.add_player game, username
        send pid, {:add_player, :ok, username}
        handle(game_updated)
      {pid, :show_game} ->
        send pid, {:current_game, game}
        handle(game)
      {pid, :death, reason} ->
        send pid, "Game Over #{inspect reason}"
      _ ->
          handle(game)
    end
  end

end
