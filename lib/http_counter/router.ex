defmodule HttpCounter.Router do
  use Plug.Router
  alias HttpCounter.Counter

  @max_counters Application.get_env(:http_counter, :max_counters)

  def via(num) do
    {:global, String.to_atom("c#{num}")}
  end

  plug(:match)
  plug(:dispatch)

  post "/counters/:name" do
    case HttpCounter.Counter.start_link(name) do
      {:ok, _} -> send_resp(conn, 201, "'#{name}' created")
      {:error, {error_msg, _}} -> send_resp(conn, 422, inspect(error_msg))
    end
  end

  put "/counters/:name/incr" do
    count = HttpCounter.Counter.incr(name)
    send_resp(conn, 200, "#{count}")
  end

  get "/counters/:name" do
    count = HttpCounter.Counter.get(name)
    send_resp(conn, 200, "#{count}")
  end

  get "/benchmark" do
    num = Enum.random(1..(2 * @max_counters))
    name = via(num)
    count = Counter.incr(name)
    send_resp(conn, 200, "#{count}")
  end

  get "/start_1" do
    1..@max_counters
    |> Enum.each(&Counter.start_link(via(&1)))

    send_resp(conn, 201, "#{@max_counters} counters created")
  end

  get "/start_2" do
    c_from = @max_counters + 1
    c_to = 2 * @max_counters

    c_from..c_to
    |> Enum.each(&Counter.start_link(via(&1)))

    send_resp(conn, 201, "#{@max_counters} counters created")
  end
end
