defmodule HttpCounter.Counter do
  use GenServer

  def start_link(name) do
    GenServer.start_link __MODULE__, :ok, name: via(name)
  end

  def via(name), do: {:via, Registry, {Registry.Counter, name}}

  def init(:ok), do: {:ok, 0}

  def incr(name) do
    GenServer.call(via(name),:incr)
  end

  def get(name),
    do: GenServer.call(via(name),:get)


  def handle_call(:incr, _from, count) do
    incr_count = count + 1
    {:reply, incr_count, incr_count}
  end

  def handle_call(:get, _from, count),
    do: {:reply, count, count}

end
