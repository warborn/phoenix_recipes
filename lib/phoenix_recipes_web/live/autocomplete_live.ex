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

      <div class="mt-12">
        <.form for={@form}>
          <.input
            type="text"
            phx-change="search"
            phx-debounce={300}
            field={@form[:search_text]}
            placeholder="Search address"
          />
          <div :if={@options != []} class="mt-1 border border-gray-100 rounded-md shadow-sm">
            <div
              :for={{label, value} <- @options}
              class="text-gray-700 text-sm p-2 hover:bg-indigo-500 hover:text-white hover:cursor-pointer"
              phx-click="address-selected"
              phx-value-place_id={value}
            >
              <span><%= label %></span>
            </div>
          </div>
        </.form>
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
    {:ok, assign(socket, result: nil, options: [], form: to_form(%{"search_text" => ""}))}
  end

  @impl true
  def handle_event("address-selected", %{"place_id" => place_id}, socket) do
    result = AddressAutocomplete.get_place(place_id)

    {:noreply, assign(socket, result: result, options: [])}
  end

  @impl true
  def handle_event("search", %{"search_text" => search_text}, socket) do
    options =
      if String.length(search_text) > 2 do
        search_text
        |> AddressAutocomplete.predictions()
        |> Enum.map(fn prediction -> {prediction.description, prediction.place_id} end)
      else
        []
      end

    {:noreply, assign(socket, options: options)}
  end
end
