defmodule KeyboardHeroesWeb.TimerChannel do

  use Phoenix.Channel
  alias KeyboardHeroes.GameServer

  def join("timer:update", _msg, socket) do
    {:ok, socket}
  end

  def handle_in("new_time", msg, socket) do
    push socket, "new_time", msg
    {:noreply, socket}
  end

  def handle_in("start_timer", payload, socket) do
    [{_,game_server}] = :ets.lookup(:"#{payload["name_room"]}","game")
    GameServer.start_timer game_server, 3
		{:noreply, socket}
	end

end
