defmodule RazoyoWeb.CarsLive.ShowCarComponent do
  use Phoenix.Component

  import Number.Currency
  import RazoyoWeb.CoreComponents

  def render(assigns) do
    assigns =
      assigns
      |> assign(:price, set_price_format(assigns))

    ~H"""
    <.modal max_width="lg" title={"#{@car_info["year"]} #{@car_info["make"]} #{@car_info["model"]}"}>
      <div class="md:grid md:grid-cols-2">
        <img class="object-contain h-96 w-full" src={@car_info["image"]} />
        <div class="w-full md:px-4 py-2">
          <.h5 class="text-grey-600">Specifications</.h5>
          <.table>
            <.tr>
              <.td class="font-semibold text-orange-600">Price</.td>
              <.td><%= @price %></.td>
            </.tr>
            <.tr>
              <.td class="font-semibold text-orange-600">MPG</.td>
              <.td><%= @car_info["mpg"] %></.td>
            </.tr>
            <.tr>
              <.td class="font-semibold text-orange-600">Seats</.td>
              <.td><%= @car_info["seats"] %></.td>
            </.tr>
          </.table>
        </div>
        <div class="flex justify-end">
          <.button label="close" phx-click={hide_modal()} />
        </div>
      </div>
    </.modal>
    """
  end

  defp set_price_format(%{car_info: %{"price" => price}}),
    do: number_to_currency(price)
end
