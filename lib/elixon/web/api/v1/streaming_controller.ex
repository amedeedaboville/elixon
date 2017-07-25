defmodule Elixon.Web.Api.V1.StreamingController do
  use Elixon.Web, :controller

  def index(conn, _params) do
    base_url = Application.get_env(:x, :streaming_api_base_url)  
    uri = URI.parse(conn.request_path)
    %{:host => new_host} = URI.parse(base_url)
    new_uri = %{ uri | :host => new_host, :scheme => 'ws', :port => 3000}
    IO.inspect(new_uri)

    redirect conn, to: URI.to_string(new_uri), external: true
    end
end
