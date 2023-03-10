defmodule RazoyoWeb.CoreComponents.Form do
  @moduledoc """
  Renders a simple form.

  ## Examples

    <.simple_form :let={f} for={:user} phx-change="validate" phx-submit="save">
      <.input field={{f, :email}} label="Email"/>
      <.input field={{f, :username}} label="Username" />
      <:actions>
        <.button>Save</.button>
      </:actions>
    </.simple_form>
  """
  use Phoenix.Component

  attr :for, :any, default: nil, doc: "the datastructure for the form"
  attr :as, :any, default: nil, doc: "the server side parameter to collect all input under"

  attr :rest, :global,
    include: ~w(autocomplete name rel action enctype method novalidate target),
    doc: "the arbitrary HTML attributes to apply to the form tag"

  slot :inner_block, required: true
  slot :actions, doc: "the slot for form actions, such as a submit button"

  def simple_form(assigns) do
    ~H"""
    <.form :let={f} for={@for} as={@as} {@rest}>
      <div class="space-y-8 bg-white mt-10">
        <%= render_slot(@inner_block, f) %>
        <div :for={action <- @actions} class="mt-2 flex items-center justify-between gap-6">
          <%= render_slot(action, f) %>
        </div>
      </div>
    </.form>
    """
  end
end
