# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

alias PhxIcons.Providers.Flagpack
alias PhxIcons.Providers.Heroicons
alias PhxIcons.Providers.Lucide
alias PhxIcons.Providers.Phosphor
alias PhxIcons.Providers.SimpleIcons
alias PhxIcons.Providers.Tabler

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.25.4",
  phx_icons_demo: [
    args:
      ~w(js/app.js --bundle --target=es2022 --outdir=../priv/static/assets/js --external:/fonts/* --external:/images/* --alias:@=.),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => [Path.expand("../deps", __DIR__), Mix.Project.build_path()]}
  ]

# Configure Elixir's Logger
config :logger, :default_formatter,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configure icons
config :phx_icons,
  providers: %{
    "heroicons" => {Heroicons, "2.2.0"},
    "heroicons-solid" => {Heroicons, "2.2.0", style: "solid"},
    "heroicons-mini" => {Heroicons, "2.2.0", style: "mini"},
    "heroicons-micro" => {Heroicons, "2.2.0", style: "micro"},
    "lucide" => {Lucide, "0.469.0"},
    "tabler" => {Tabler, "3.41.1"},
    "phosphor" => {Phosphor, "2.0.8"},
    "simple-icons" => {SimpleIcons, "16.16.0"},
    "flagpack" => {Flagpack, "2.1.0"}
  }

# Configure the endpoint
config :phx_icons_demo, PhxIconsDemoWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: PhxIconsDemoWeb.ErrorHTML, json: PhxIconsDemoWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: PhxIconsDemo.PubSub,
  live_view: [signing_salt: "HuyutNam"]

config :phx_icons_demo,
  generators: [timestamp_type: :utc_datetime]

# Configure tailwind (the version is required)
config :tailwind,
  version: "4.1.12",
  phx_icons_demo: [
    args: ~w(
      --input=assets/css/app.css
      --output=priv/static/assets/css/app.css
    ),

    # Import environment specific config. This must remain at the bottom
    # of this file so it overrides the configuration defined above.
    cd: Path.expand("..", __DIR__)
  ]

import_config "#{config_env()}.exs"
