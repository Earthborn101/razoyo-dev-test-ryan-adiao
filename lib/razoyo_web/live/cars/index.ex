defmodule RazoyoWeb.CarsLive.Index do
  use Phoenix.LiveView

  import RazoyoWeb.CoreComponents

  alias Razoyo.API.Cars

  def mount(params, _, socket) do
    {:ok, socket}
  end

  def handle_params(params, _, %{assigns: %{live_action: live_action}} = socket) do
    {:noreply,
     socket
     |> live_action(params, live_action)}
  end

  defp live_action(socket, params, :index) do
    socket
    |> assign_filter(params)
    |> assign_cars()
  end

  defp live_action(%{assigns: %{token: token}} = socket, %{"id" => id} = params, :show) do
    socket
    |> assign(:car_info, Cars.get_car(id, token))
  end

  def handle_event("show_modal", %{"id" => id}, socket) do
    {:noreply,
     socket
     |> push_patch(to: "/cars/#{id}")}
  end

  def handle_event("close_modal", _, %{assigns: assigns} = socket) do
    {:noreply,
     socket
     |> assign(:car_info, nil)
     |> push_patch(to: set_url("/cars", assigns))}
  end

  defp set_url(url, %{filter: %{make: make}}) do
    "#{url}?make=#{make}"
  end

  defp set_url(url, _), do: url

  defp assign_filter(socket, params) do
    case params["make"] do
      nil ->
        socket
        |> assign(:filter, %{})

      make ->
        socket
        |> assign(:filter, %{make: make})
    end
  end

  defp assign_cars(%{assigns: %{filter: filter}} = socket) do
    assign_cars(socket, filter)
  end

  defp assign_cars(socket) do
    assign_cars(socket, %{})
  end

  defp assign_cars(socket, filter) do
    return = Cars.list_cars(filter)

    socket
    |> assign(:token, return.token)
    |> assign(:makes, return.makes)
    |> assign(:cars, return.cars)
  end
end
