defmodule Elixon.Web.Router do
  use Elixon.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Elixon.Web do
    pipe_through :api
  end
end
