defmodule HttpCounter.Counter do
  use GenServer

  def start_link(name) do
    GenServer.start_link(__MODULE__, :ok, name: name)
  end

  def init(:ok), do: {:ok, 0}

  def incr(pid) do
    GenServer.call(pid, :incr)
  end

  def get(pid),
    do: GenServer.call(pid, :get)

  def handle_call(:incr, _from, count) do
    incr_count = count + 1
    {:reply, incr_count, incr_count}
  end

  def handle_call(:get, _from, count),
    do: {:reply, count, count}
end
