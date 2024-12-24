defmodule PhoenixRecipes.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_recipes,
    adapter: Ecto.Adapters.Postgres
end
