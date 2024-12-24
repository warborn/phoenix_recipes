defmodule PhoenixRecipesWeb.ApiJSON do
  @moduledoc false

  def query(%{predictions: predictions}) do
    %{data: for(prediction <- predictions, do: data(prediction))}
  end

  defp data(prediction) do
    %{
      description: prediction[:description],
      place_id: prediction[:place_id]
    }
  end
end
