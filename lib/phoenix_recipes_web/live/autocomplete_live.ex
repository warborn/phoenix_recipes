defmodule PhoenixRecipesWeb.AutocompleteLive do
  use PhoenixRecipesWeb, :live_view

  alias PhoenixRecipes.AddressAutocomplete

  @impl true
  def render(assigns) do
    ~H"""
    <div class="h-full w-2xl">
      <h1 class="text-2xl font-bold text-gray-800">Autocomplete!</h1>

      <div
        id="autocomplete"
        class="autocomplete mt-4"
        phx-hook="AddressAutocompleteHook"
        phx-update="ignore"
      >
        <input
          class="pc-text-input w-full rounded-md border-0 py-2 pl-3 pr-12 shadow-sm ring-1 ring-inset ring-gray-300 dark:ring-gray-600 sm:text-sm sm:leading-6"
          placeholder="Search address"
        />
        <ul
          class="absolute z-10 mt-1 max-h-60 w-full overflow-auto rounded-md bg-white py-1 text-base shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none sm:text-sm"
          role="listbox"
        >
        </ul>
      </div>

      <div :if={@result} class="mt-12 border rounded-lg overflow-x-auto overflow-y-auto h-96">
        <pre>
          <%= inspect(@result, pretty: true)%>
        </pre>
      </div>
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, result: nil)}
  end

  @impl true
  def handle_event("address-selected", %{"place_id" => place_id}, socket) do
    result = AddressAutocomplete.get_place(place_id)

    {:noreply, assign(socket, result: result)}
  end
end
