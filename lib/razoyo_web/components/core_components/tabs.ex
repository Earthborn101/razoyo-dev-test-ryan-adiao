defmodule RazoyoWeb.CoreComponents.Tabs do
  @moduledoc """
  Renders PETAL navigation tabs.

  ## Examples
    ## Pill
    <.tabs>
      <.tab is_active to="/">Home</.tab>
      <.tab link_type="a" to="/" label="About" />
    </.tabs>

    ## Underline
    <.tabs>
      <.tab underline is_active to="/">Home</.tab>
      <.tab underline link_type="a" to="/" label="About" />
    </.tabs>
  """
  use Phoenix.Component

  alias RazoyoWeb.CoreComponents, as: CC

  import RazoyoWeb.CoreComponents.Helpers

  attr :class, :string
  attr :underline, :boolean, default: false
  slot :inner_block

  def tabs(assigns) do
    assigns =
      assigns
      |> assign_new(:underline, fn -> false end)
      |> assign_new(:class, fn -> "" end)
      |> assign_rest(~w(underline class)a)

    ~H"""
    <div
      {@rest}
      class={
        build_class(
          [
            "flex gap-x-8 gap-y-2",
            if(@underline, do: "border-b border-gray-200 dark:border-gray-600", else: ""),
            @class
          ],
          " "
        )
      }
    >
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  attr :class, :string
  attr :label, :string
  attr :link_type, :string, values: ["a", "live_patch", "live_redirect"]
  attr :number, :integer
  attr :underline, :boolean, default: false
  attr :is_active, :boolean, default: false
  slot :inner_block

  def tab(assigns) do
    assigns =
      assigns
      |> assign_new(:label, fn -> nil end)
      |> assign_new(:class, fn -> "" end)
      |> assign_new(:inner_block, fn -> nil end)
      |> assign_new(:number, fn -> nil end)
      |> assign_new(:link_type, fn -> "a" end)
      |> assign_new(:is_active, fn -> false end)
      |> assign_new(:underline, fn -> false end)
      |> assign_rest(~w(class number link_type is_active underline label)a)

    ~H"""
    <CC.a
      link_type={@link_type}
      label={@label}
      to={@to}
      class={[get_tab_class(@is_active, @underline), @class]}
      {@rest}
    >
      <%= if @number do %>
        <.render_label_or_slot {assigns} />

        <span class={get_tab_number_class(@is_active, @underline)}>
          <%= @number %>
        </span>
      <% else %>
        <.render_label_or_slot {assigns} />
      <% end %>
    </CC.a>
    """
  end

  def render_label_or_slot(assigns) do
    ~H"""
    <%= if @inner_block do %>
      <%= render_slot(@inner_block) %>
    <% else %>
      <%= @label %>
    <% end %>
    """
  end

  # Pill CSS
  defp get_tab_class(is_active, false) do
    base_classes = "whitespace-nowrap px-3 py-2 flex font-medium items-center text-sm rounded-md"

    active_classes =
      if is_active,
        do: "bg-primary-100 dark:bg-gray-800 text-primary-600 dark:text-primary-500",
        else:
          "text-gray-500 hover:text-gray-600 dark:hover:text-gray-300 dark:text-gray-400 dark:hover:bg-gray-800 hover:bg-gray-100"

    build_class([base_classes, active_classes])
  end

  # Underline CSS
  defp get_tab_class(is_active, underline) do
    base_classes = "whitespace-nowrap flex items-center py-3 px-3 border-b-2 font-medium text-sm"

    active_classes =
      if is_active,
        do: "border-primary-500 text-primary-600 dark:text-primary-500 dark:border-primary-500",
        else:
          "border-transparent text-gray-500 dark:hover:text-gray-300 dark:text-gray-400 hover:border-gray-300 hover:text-gray-600"

    underline_classes =
      if is_active && underline,
        do: "",
        else: "hover:border-gray-300"

    build_class([base_classes, active_classes, underline_classes])
  end

  # Underline
  defp get_tab_number_class(is_active, true) do
    base_classes = "whitespace-nowrap ml-2 py-0.5 px-2 rounded-full text-xs font-normal"

    active_classes =
      if is_active,
        do: "bg-primary-100 text-primary-600",
        else: "bg-gray-100 text-gray-500"

    underline_classes =
      if is_active,
        do: "bg-primary-100 dark:bg-primary-600 text-primary-600 dark:text-white",
        else: "bg-gray-100 dark:bg-gray-600 dark:text-white text-gray-500"

    build_class([base_classes, active_classes, underline_classes])
  end

  # Pill
  defp get_tab_number_class(is_active, false) do
    base_classes = "whitespace-nowrap ml-2 py-0.5 px-2 rounded-full text-xs font-normal"

    active_classes =
      if is_active,
        do: "bg-primary-600 text-white",
        else: "bg-gray-500 dark:bg-gray-600 text-white"

    build_class([base_classes, active_classes])
  end
end
