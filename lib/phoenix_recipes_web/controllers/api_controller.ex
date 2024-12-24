defmodule PhoenixRecipesWeb.ApiController do
  use Phoenix.Controller, formats: [:json]

  alias PhoenixRecipes.AddressAutocomplete

  def query(conn, params) do
    case params do
      %{"place" => place} ->
        predictions = AddressAutocomplete.predictions(place)
        render(conn, :query, predictions: predictions)

      _ ->
        {:error, :not_found}
    end
  end
end
