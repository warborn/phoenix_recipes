defmodule PhoenixRecipes.AddressAutocomplete do
  @moduledoc false

  def predictions(text) do
    case GoogleMaps.place_autocomplete(text) do
      {:ok, %{"predictions" => predictions}} ->
        Enum.map(predictions, &extract_fields/1)
    end
  end

  def get_place(place_id) do
    case GoogleMaps.place_details(place_id) do
      {:ok, %{"result" => result}} ->
        result

      {:error, _, _} ->
        nil
    end
  end

  defp extract_fields(%{"description" => description, "place_id" => place_id}) do
    %{
      description: description,
      place_id: place_id
    }
  end
end
