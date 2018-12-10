# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :mentions,
  ecto_repos: [Mentions.Repo],
  screen_name: "Skoda091"

# Configures the endpoint
config :mentions, MentionsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "nwtEqlC9bMARSR+x19roCl1r9CoDaVQ9bKp+qEt1/kmLi4qriMCg2GLiAqoVnn+G",
  render_errors: [view: MentionsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Mentions.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

config :extwitter, :oauth, [
    consumer_key: "<consumer_key>",
    consumer_secret: "<consumer_secret>",
    access_token: "<access_token>",
    access_token_secret: "<access_token_secret>"
 ]

config :mentions, Mentions.Scheduler,
  jobs: [
    # Every minute
    {"* * * * *", {Mentions.Tweets, :fetch_and_save, []}},
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
