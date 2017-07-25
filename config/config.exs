# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :elixon,
  ecto_repos: [Elixon.Repo]

# Configures the endpoint
config :elixon, Elixon.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1KTubFBDd9yIQzptJ60i8yLcZ8kykNZCb59dyu98wgi7RkujUlbPY5y1xImxGhbi",
  render_errors: [view: Elixon.Web.ErrorView, accepts: ~w(json)],
  pubsub: [name: Elixon.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :authable,
  ecto_repos: [Authable.Repo],
  repo: Authable.Repo,
  resource_owner: Authable.Model.User,
  token_store: Authable.Model.Token,
  client: Authable.Model.Client,
  app: Authable.Model.App,
  expires_in: %{
        access_token: 3600,
        refresh_token: 24 * 3600,
        authorization_code: 300,
        session_token: 30 * 24 * 3600
      },
  grant_types: %{
        authorization_code: Authable.GrantType.AuthorizationCode,
        client_credentials: Authable.GrantType.ClientCredentials,
        password: Authable.GrantType.Password,
      },
  auth_strategies: %{
        headers: %{
                "authorization" => [
                          {~r/Basic ([a-zA-Z\-_\+=]+)/, Authable.Authentication.Basic},
                          {~r/Bearer ([a-zA-Z\-_\+=]+)/, Authable.Authentication.Bearer},
                        ],
                "x-api-token" => [
                          {~r/([a-zA-Z\-_\+=]+)/, Authable.Authentication.Bearer}
                        ]
              },
        query_params: %{
                "access_token" => Authable.Authentication.Bearer
              },
        sessions: %{
                "session_token" => Authable.Authentication.Session
              }
      },
  scopes: ~w(read write session),
  renderer: Authable.Renderer.RestApi

config :canary, repo: Elixon.Repo

import_config "initializers/ostatus.exs"
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
