defmodule HttpCounter.Router do
  use Plug.Router

  plug :match
  plug :dispatch


  post "/counters/:name" do
    case HttpCounter.Counter.start_link(name) do
      {:ok, _} -> send_resp(conn, 201, "'#{name}' created")
      {:error, {error_msg,_}} -> send_resp(conn, 422, inspect(error_msg))
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

end
