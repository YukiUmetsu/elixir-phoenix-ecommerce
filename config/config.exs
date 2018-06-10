# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :mango,
  ecto_repos: [Mango.Repo]

# Configures the endpoint
config :mango, MangoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "CQeqkSscWD7sgB+GrTOMEgplzv7QY5h+984nljry7td71xcPJB/7Gc7ZkGeJrafv",
  render_errors: [view: MangoWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Mango.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

config :mango, Mango.Mailer,
       adapter: Bamboo.SMTPAdapter,
       server: System.get_env("SMTP_SERVER"),
       hostname: "localhost",
       port: 465,
       username: System.get_env("SMTP_USERNAME"), # or {:system, "SMTP_USERNAME"}
       password: System.get_env("SMTP_PASSWORD"), # or {:system, "SMTP_PASSWORD"}
       tls: :if_available, # can be `:always` or `:never`
       allowed_tls_versions: [:"tlsv1", :"tlsv1.1", :"tlsv1.2"], # or {":system", ALLOWED_TLS_VERSIONS"} w/ comma seprated values (e.g. "tlsv1.1,tlsv1.2")
       ssl: true, # can be `true`
       retries: 1,
       no_mx_lookups: false, # can be `true`
       auth: :if_available # can be `always`. If your smtp relay requires authentication set it to `always`.

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
