defmodule Periodical.Task do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, :no_state)
  end

  @spec init(any) :: {:ok, any}
  def init(state) do
    Process.send_after(self(), :work, 60 * 1000) # In 1 minute
    {:ok, state}
  end

  def handle_info(:work, state) do
    Periodical.Jobs.delete_all()
    Periodical.sync_jobs()
    # Start the timer again
    Process.send_after(self(), :work, 24 * 60 * 60 * 1000) # In 24 hours

    {:noreply, state}
  end
end
