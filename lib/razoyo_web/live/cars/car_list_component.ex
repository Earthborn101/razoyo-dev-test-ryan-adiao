defmodule RazoyoWeb.CarsLive.CarListComponent do
  use Phoenix.Component

  import RazoyoWeb.CoreComponents

  def render(assigns) do
    ~H"""
    <div class="flex justify-center">
      <div class="w-full lg:w-3/4 px-4 lg:px-0">
        <%= if Enum.empty?(@cars) do %>
          <div class="my-8 mx-4 flex justify-center">
            <.h2>Sorry. No results found!</.h2>
          </div>
        <% else %>
          <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3">
            <%= for car <- @cars do %>
              <.car_card {car} />
            <% end %>
          </div>
        <% end %>
      </div>
    </div>
    """
  end

  defp car_card(assigns) do
    assigns =
      assigns
      |> assign(:heading, set_heading(assigns))
      |> assign(:id, assigns["id"])

    ~H"""
    <.card class="mx-2 my-4">
      <.card_content class="max-w-sm text-black" heading={@heading} />
      <.card_footer>
        <.button color="secondary" phx_click="show_modal" phx_value_id={@id} variant="outline">
          View
        </.button>
      </.card_footer>
    </.card>
    """
  end

  defp set_heading(%{"year" => year, "make" => make, "model" => model}),
    do: "#{year} #{make} #{model}"
end
