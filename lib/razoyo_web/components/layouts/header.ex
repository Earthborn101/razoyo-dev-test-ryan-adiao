defmodule RazoyoWeb.Components.Layouts.Header do
  @moduledoc """
  Renders navigation header for the portfolio.
  """
  use Phoenix.Component

  import RazoyoWeb.CoreComponents

  def render(assigns) do
    ~H"""
    <div class="w-full py-5 px-4 lg:px-2 flex justify-start lg:justify-center h-1/5">
      <div class="text-3xl w-full lg:w-3/4">
        <.a link_type="live_redirect" to="/cars">
          <span class="font-light font-sans text-gray-800">CARS</span>
          <span class="font-semibold font-sans text-orange-600">CATALOG</span>
        </.a>
      </div>
    </div>
    """
  end
end
