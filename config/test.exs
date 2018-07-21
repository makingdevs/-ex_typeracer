use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :keyboard_heroes, KeyboardHeroesWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :keyboard_heroes, KeyboardHeroes.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "keyboard_heroes_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  template: "template0"

  config :keyboard_heroes, KeyboardHeroes.Mail.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: "email-smtp.us-east-1.amazonaws.com",
  port: 587,
  username: System.get_env("SMTP_USERNAME"),
  password: System.get_env("SMTP_PASSWORD"),
  tls: :if_available, # can be `:always` or `:never`
  ssl: false, # can be `true`
  retries: 1
