defmodule RazoyoWeb.CoreComponents.Dropdown do
  @moduledoc """
  Renders dropdown component.

  ## Example
    <.dropdown label="Dropdown" js_lib="alpine_js|live_view_js">
      <.dropdown_menu_item link_type="button">
        <Heroicons.home class="w-5 h-5 text-gray-500" />
        Button item with icon
      </.dropdown_menu_item>
      <.dropdown_menu_item link_type="a" to="/" label="a item" />
      <.dropdown_menu_item link_type="live_patch" to="/" label="Live Patch item" />
      <.dropdown_menu_item link_type="live_redirect" to="/" label="Live Redirect item" />
    </.dropdown>
  """
  use Phoenix.Component
  import RazoyoWeb.CoreComponents.Helpers
  alias Phoenix.LiveView.JS
  alias RazoyoWeb.CoreComponents, as: CC

  @transition_in_base "transition transform ease-out duration-100"
  @transition_in_start "transform opacity-0 scale-95"
  @transition_in_end "transform opacity-100 scale-100"

  @transition_out_base "transition ease-in duration-75"
  @transition_out_start "transform opacity-100 scale-100"
  @transition_out_end "transform opacity-0 scale-95"

  attr :js_lib, :string, default: "alpine_js", values: ["alpine_js", "live_view_js"]
  attr :label, :string
  attr :placement, :string, values: ["left", "right"]
  attr :active, :boolean, default: false
  attr :class, :string
  slot :inner_block
  slot :trigger_element

  def dropdown(assigns) do
    assigns =
      assigns
      |> assign_new(:options_container_id, fn -> "dropdown_#{Enum.random(10_000..99_999)}" end)
      |> assign_new(:js_lib, fn -> "alpine_js" end)
      |> assign_new(:placement, fn -> "left" end)
      |> assign_new(:label, fn -> nil end)
      |> assign_new(:trigger_element, fn -> nil end)
      |> assign_new(:active, fn -> false end)
      |> assign_new(:class, fn -> nil end)
      |> assign_rest(~w(options_container_id js_lib placement label trigger_element class)a)

    ~H"""
    <div
      {@rest}
      {js_attributes("container", @js_lib, @options_container_id)}
      class={["relative inline-block text-left", @class]}
    >
      <div>
        <button
          type="button"
          class={[trigger_button_classes(@label, @trigger_element), active_class(@active)]}
          {js_attributes("button", @js_lib, @options_container_id)}
          aria-haspopup="true"
        >
          <span class="sr-only">Open options</span>

          <%= if @label do %>
            <div class="flex flex-row">
              <%= @label %>
              <Heroicons.chevron_down solid class="w-5 h-5 ml-2 -mr-1 dark:text-gray-100" />
            </div>
          <% end %>

          <%= if @trigger_element do %>
            <%= render_slot(@trigger_element) %>
          <% end %>

          <%= if !@label && !@trigger_element do %>
            <Heroicons.ellipsis_vertical solid class="w-5 h-5" />
          <% end %>
        </button>
      </div>
      <div
        {js_attributes("options_container", @js_lib, @options_container_id)}
        class={[
          placement_class(@placement),
          "absolute z-30 mt-2 bg-white dark:bg-gray-800 rounded-md shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none",
          @class
        ]}
        role="menu"
        id={@options_container_id}
        aria-orientation="vertical"
        aria-labelledby="options-menu"
      >
        <div class="py-1" role="none">
          <%= render_slot(@inner_block) %>
        </div>
      </div>
    </div>
    """
  end

  def dropdown_menu_item(assigns) do
    assigns =
      assigns
      |> assign_new(:active, fn -> false end)
      |> assign_new(:link_type, fn -> "button" end)
      |> assign_new(:inner_block, fn -> nil end)
      |> assign_new(:to, fn -> nil end)
      |> assign_new(:classes, fn -> dropdown_menu_item_classes() end)
      |> assign_rest(~w(classes link_type)a)

    ~H"""
    <CC.a link_type={@link_type} to={@to} class={[@classes, active_option_class(@active)]} {@rest}>
      <div class="w-full grid grid-cols-2">
        <div class="w-3/4">
          <%= if @inner_block do %>
            <%= render_slot(@inner_block) %>
          <% else %>
            <%= @label %>
          <% end %>
        </div>
        <%= if @active do %>
          <div class="ml-auto">
            <Heroicons.check solid class="w-4 h-4 text-orange-500" />
          </div>
        <% end %>
      </div>
    </CC.a>
    """
  end

  defp active_class(true),
    do: "border border-orange-400 text-orange-600 bg-orange-50"

  defp active_class(_),
    do: "border border-gray-600 text-gray-700 dark:text-gray-300 bg-white"

  defp active_option_class(true),
    do: "text-orange-600 bg-orange-50 hover:bg-orange-100"

  defp active_option_class(_),
    do: "hover:bg-gray-100"

  defp trigger_button_classes(nil, []),
    do:
      "flex items-center rounded-full hover:text-gray-600 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-offset-gray-100 focus:ring-primary-500"

  defp trigger_button_classes(_label, []),
    do:
      "inline-flex justify-center w-full px-4 py-2 text-sm font-medium bg-white rounded-md shadow-sm dark:bg-gray-900 dark:hover:bg-gray-800 dark:focus:bg-gray-800 hover:bg-gray-50 focus:outline-none"

  defp trigger_button_classes(_label, _trigger_element), do: "align-middle"

  defp dropdown_menu_item_classes(),
    do:
      "block flex items-center self-start dark:hover:bg-gray-700 dark:text-gray-300 justify-start px-4 py-2 text-sm text-gray-700 transition duration-150 dark:bg-gray-800 ease-in-out w-full text-left"

  defp js_attributes("container", "alpine_js", _options_container_id) do
    %{
      "x-data": "{open: false}",
      "@keydown.escape.stop": "open = false",
      "@click.outside": "open = false"
    }
  end

  defp js_attributes("button", "alpine_js", _options_container_id) do
    %{
      "@click": "open = !open",
      "@click.outside": "open = false",
      "x-bind:aria-expanded": "open.toString()"
    }
  end

  defp js_attributes("options_container", "alpine_js", _options_container_id) do
    %{
      "x-cloak": true,
      "x-show": "open",
      "x-transition:enter": @transition_in_base,
      "x-transition:enter-start": @transition_in_start,
      "x-transition:enter-end": @transition_in_end,
      "x-transition:leave": @transition_out_base,
      "x-transition:leave-start": @transition_out_start,
      "x-transition:leave-end": @transition_out_end
    }
  end

  defp js_attributes("container", "live_view_js", options_container_id) do
    %{
      "phx-click-away":
        JS.hide(
          to: "##{options_container_id}",
          transition: {@transition_out_base, @transition_out_start, @transition_out_end}
        )
    }
  end

  defp js_attributes("button", "live_view_js", options_container_id) do
    %{
      "phx-click":
        JS.toggle(
          to: "##{options_container_id}",
          display: "block",
          in: {@transition_in_base, @transition_in_start, @transition_in_end},
          out: {@transition_out_base, @transition_out_start, @transition_out_end}
        )
    }
  end

  defp js_attributes("options_container", "live_view_js", _options_container_id) do
    %{
      style: "display: none;"
    }
  end

  defp placement_class("left"), do: "right-0 origin-top-right"
  defp placement_class("right"), do: "left-0 origin-top-left"
end
