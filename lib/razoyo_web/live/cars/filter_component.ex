defmodule RazoyoWeb.CarsLive.FilterComponent do
  use Phoenix.Component

  import RazoyoWeb.CoreComponents

  def render(assigns) do
    assigns =
      assigns
      |> assign(:active, set_active(assigns))
      |> assign(:makes, add_any_option(assigns))
      |> assign(:dropdown_label, dropdown_label(assigns))

    ~H"""
    <div class="flex justify-center">
      <div class="w-full lg:w-3/4 px-4 lg:px-2 flex flex-col sm:flex-row mx-2">
        <.p class="font-thin mt-2 flex justify-center sm:justify-start">Filter by:</.p>
        <div class="px-2 py-4 sm:py-0">
          <.dropdown
            class="w-full sm:w-32"
            active={@active}
            js_lib="live_view_js"
            label={@dropdown_label}
            placement="right"
          >
            <%= for make <- @makes do %>
              <.option make={make} filter={@filter} />
            <% end %>
          </.dropdown>
        </div>
      </div>
    </div>
    """
  end

  defp option(assigns) do
    assigns =
      assigns
      |> assign_new(:to, fn -> set_link(assigns) end)
      |> assign_new(:active, fn -> active_menu_item(assigns) end)

    ~H"""
    <.dropdown_menu_item active={@active} link_type="live_redirect" to={@to}>
      <.p><%= @make %></.p>
    </.dropdown_menu_item>
    """
  end

  defp add_any_option(%{makes: makes}) do
    ["Any"] ++ makes
  end

  defp set_link(%{make: "Any"}) do
    "/cars"
  end

  defp set_link(%{make: make}) do
    "/cars?make=#{make}"
  end

  defp set_active(%{makes: makes, filter: %{make: filter_make}}) do
    Enum.any?(makes, fn make -> make == filter_make end)
  end

  defp set_active(_) do
    false
  end

  defp active_menu_item(%{make: make, filter: %{make: filter_make}} = assigns) do
    make == filter_make
  end

  defp active_menu_item(_), do: false

  defp dropdown_label(%{cars: []}), do: "Make"

  defp dropdown_label(%{filter: filter}) do
    case filter[:make] do
      nil -> "by: Make"
      make -> make
    end
  end
end
