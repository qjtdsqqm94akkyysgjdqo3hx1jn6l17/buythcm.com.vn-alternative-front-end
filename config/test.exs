import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :buyt_hcm_alt_frontend, BuytHcmAltFrontendWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "djSTIZxJzV1bL0tPUz+R0qkvQScVmzBi1eMvQhgi9wakJTb9KpRayNTWvRFqeOPu",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
