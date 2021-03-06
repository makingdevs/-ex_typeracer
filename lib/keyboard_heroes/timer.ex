defmodule KeyboardHeroes.Timer do

  use GenServer
  require Logger

  def start_link() do
    GenServer.start_link __MODULE__, %{}
  end

  ## Gen server starts here!

  def init(_state) do
    KeyboardHeroesWeb.Endpoint.subscribe "timer:start", []
    # Adding state
    state = %{timer_ref: nil, timer: nil}
    {:ok, state}
  end

  def handle_info(:update, %{timer: 0, uuid: uuid}) do
    broadcast 0, %{message: "Se acabo el tiempo!", uuid: uuid}
    {:noreply, %{timer_ref: nil, timer: 0}}
  end

  def handle_info(:update, %{timer: time, uuid: uuid}) do
    leftover = time-1
    timer_ref = schedule_timer 1_000
    broadcast leftover, %{message: "Contando...", uuid: uuid}
    {:noreply, %{timer_ref: timer_ref, timer: leftover, uuid: uuid}}
  end

	def handle_info(%{event: "start_timer", payload: uuid },%{timer_ref: old_timer_ref}) do
    cancel_timer(old_timer_ref)
		duration = 3
		timer_ref = schedule_timer 1_000
		broadcast duration, %{message: "Start time", uuid: uuid.uuid}
		{:noreply, %{timer_ref: timer_ref, timer: duration, uuid: uuid.uuid}}
  end

	def handle_info({:start_timer} , %{timer_ref: old_timer_ref}) do
    cancel_timer(old_timer_ref)
		duration = 3
		timer_ref = schedule_timer 1_000
		broadcast duration, %{message: "Start time"}
		{:noreply, %{timer_ref: timer_ref, timer: duration}}
  end

  defp schedule_timer(interval) do
    Process.send_after self(), :update, interval
  end

  defp cancel_timer(nil), do: :ok
  defp cancel_timer(ref), do: Process.cancel_timer(ref)

  defp broadcast(time, response) do
    KeyboardHeroesWeb.Endpoint.broadcast! "timer:update", "new_time_#{response.uuid}", %{ response: response.message, time: time}
  end

end
