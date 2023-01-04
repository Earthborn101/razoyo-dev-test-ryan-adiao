defmodule RazoyoWeb.CoreComponents.Table do
  @moduledoc """
  Renders a table.

  ## Example
    <.table>
      <.tr>
        <.th>Column 1</.th>
        <.th>Column 2</.th>
      </.tr>
      <.tr>
        <.td>Column 1 Row 1</.td>
        <.td>Column 2 Row 1</.td>
      </.tr>
      <.tr>
        <.td>Column 1 Row 2</.td>
        <.td>Column 2 Row 2</.td>
      </.tr>
    </.table>
  """
  use Phoenix.Component

  import RazoyoWeb.CoreComponents
  import RazoyoWeb.CoreComponents.Helpers

  attr :class, :string
  slot :inner_block

  def table(assigns) do
    assigns =
      assigns
      |> assign_new(:class, fn -> "" end)
      |> assign_new(:rest, fn ->
        assigns_to_attributes(assigns, ~w(
            class
          )a)
      end)

    ~H"""
    <table
      class={
        build_class([
          "min-w-full overflow-hidden divide-y ring-1 ring-gray-200 dark:ring-0 divide-gray-200 rounded-sm table-auto dark:divide-y-0 dark:divide-gray-800 sm:rounded",
          @class
        ])
      }
      {@rest}
    >
      <%= render_slot(@inner_block) %>
    </table>
    """
  end

  attr :class, :string
  slot :inner_block

  def th(assigns) do
    assigns =
      assigns
      |> assign_new(:class, fn -> "" end)
      |> assign_new(:rest, fn ->
        assigns_to_attributes(assigns, ~w(
            class
          )a)
      end)

    ~H"""
    <th
      class={
        build_class(
          [
            "px-6 py-3 text-xs font-medium tracking-wider text-left text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-300",
            @class
          ],
          " "
        )
      }
      {@rest}
    >
      <%= if @inner_block do %>
        <%= render_slot(@inner_block) %>
      <% end %>
    </th>
    """
  end

  attr :class, :string
  slot :inner_block

  def tr(assigns) do
    assigns =
      assigns
      |> assign_new(:class, fn -> "" end)
      |> assign_new(:rest, fn ->
        assigns_to_attributes(assigns, ~w(
            class
          )a)
      end)

    ~H"""
    <tr
      class={
        build_class([
          "border-b dark:border-gray-700 bg-white dark:bg-gray-800 last:border-none",
          @class
        ])
      }
      {@rest}
    >
      <%= render_slot(@inner_block) %>
    </tr>
    """
  end

  attr :class, :string
  slot :inner_block

  def td(assigns) do
    assigns =
      assigns
      |> assign_new(:class, fn -> "" end)
      |> assign_new(:rest, fn ->
        assigns_to_attributes(assigns, ~w(
            class
          )a)
      end)

    ~H"""
    <td
      class={
        build_class(
          [
            "px-6 py-2 text-sm text-gray-500 dark:text-gray-400",
            @class
          ],
          " "
        )
      }
      {@rest}
    >
      <%= render_slot(@inner_block) %>
    </td>
    """
  end

  attr :avatar_assigns, :any
  attr :class, :string
  attr :label, :string
  attr :sub_label, :string
  slot :inner_block

  def user_inner_td(assigns) do
    assigns =
      assigns
      |> assign_new(:class, fn -> "" end)
      |> assign_new(:avatar_assigns, fn -> nil end)
      |> assign_rest(~w(class avatar_assigns label sub_label)a)

    ~H"""
    <div class={@class} {@rest}>
      <div class="flex items-center gap-3">
        <%= if @avatar_assigns do %>
          <.avatar {@avatar_assigns} />
        <% end %>

        <div class="flex flex-col overflow-hidden">
          <div class="overflow-hidden font-medium text-gray-900 whitespace-nowrap text-ellipsis dark:text-gray-300">
            <%= @label %>
          </div>
          <div class="overflow-hidden font-normal text-gray-500 whitespace-nowrap text-ellipsis">
            <%= @sub_label %>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
