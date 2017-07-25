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

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
