defmodule Elixon.Web.Helpers do
  import Plug.Conn
  import Phoenix.Controller

  def render_empty(conn) do
      conn |> send_resp(201, "")
  end
end
