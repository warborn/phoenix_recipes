defmodule PhoenixRecipesWeb.MapLive do
  use PhoenixRecipesWeb, :live_view

  @attractions [
    [-117.92053664465006, 33.81115995986345],
    [-117.91757819187785, 33.81100097317143],
    [-117.92247054082354, 33.81215983080281],
    [-117.92030331607128, 33.81240942885339],
    [-117.91903731349323, 33.813452384256856],
    [-117.92110797870988, 33.814762746118774],
    [-117.91875836377658, 33.81534215144098],
    [-117.91839358337273, 33.81591263897725]
  ]

  @impl true
  def render(assigns) do
    ~H"""
    <div class="h-screen w-screen">
      <div class="absolute z-10 top-10 left-10">
        <button
          type="button"
          class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 me-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800"
          phx-click="show-random-attraction"
        >
          Show me the next attraction!
        </button>
      </div>
      <div id="map" class="h-screen w-screen" phx-hook="MapHook" data-access-token={@access_token} />
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    access_token = Application.get_env(:phoenix_recipes, :mapbox) |> Keyword.get(:access_token)

    {:ok, assign(socket, access_token: access_token)}
  end

  @impl true
  def handle_event("show-random-attraction", _params, socket) do
    location = Enum.take_random(@attractions, 1) |> hd()

    {:noreply, socket |> push_event("add-marker", %{location: location})}
  end
end
