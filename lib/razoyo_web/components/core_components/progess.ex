defmodule RazoyoWeb.CoreComponents.Progress do
  @moduledoc """
  Renders a PETAL progess bar.

  ## Examples
    <.progress color="primary" value={10} max={100} class="max-w-full" />
    <.progress color="secondary" value={20} max={100} class="max-w-full" />
    <.progress color="info" value={30} max={100} class="max-w-full" />
    <.progress color="success" value={40} max={100} class="max-w-full" />
    <.progress color="warning" value={50} max={100} class="max-w-full" />
    <.progress color="danger" value={60} max={100} class="max-w-full" />
    <.progress color="gray" value={70} max={100} class="max-w-full" />
  """
  use Phoenix.Component
  import RazoyoWeb.CoreComponents.Helpers

  attr :size, :string, values: ["xs", "sm", "md", "lg", "xl"]
  attr :color, :string, values: ["primary", "secondary", "info", "success", "warning", "danger"]
  attr :class, :string
  attr :value, :integer
  attr :max, :integer
  attr :label, :string

  def progress(assigns) do
    assigns =
      assigns
      |> assign_new(:label, fn -> "" end)
      |> assign_new(:class, fn -> "" end)
      |> assign_new(:size, fn -> "md" end)
      |> assign_new(:value, fn -> nil end)
      |> assign_new(:color, fn -> "primary" end)
      |> assign_new(:max, fn -> 100 end)
      |> assign_rest(~w(label class size value color max)a)

    ~H"""
    <div {@rest} class={@class}>
      <div class={"#{get_parent_classes(@size)} flex overflow-hidden #{get_parent_color_classes(@color)}"}>
        <span
          class={"#{get_color_classes(@color)} text-xs flex flex-col text-center text-white justify-center whitespace-nowrap font-normal leading-6 px-4 py-2"}
          style={"width: #{round(@value/@max*100)}%"}
        >
          <%= if @size == "xl" do %>
            <%= @label %>
          <% end %>
        </span>
      </div>
    </div>
    """
  end

  defp get_color_classes("primary"), do: "bg-primary-500"
  defp get_color_classes("secondary"), do: "bg-secondary-500"
  defp get_color_classes("info"), do: "bg-blue-500"
  defp get_color_classes("success"), do: "bg-green-500"
  defp get_color_classes("warning"), do: "bg-yellow-500"
  defp get_color_classes("danger"), do: "bg-red-500"
  defp get_color_classes("gray"), do: "bg-gray-500"

  defp get_parent_classes("xs"), do: "h-1 rounded-sm"
  defp get_parent_classes("sm"), do: "h-2 rounded-md"
  defp get_parent_classes("md"), do: "h-3 rounded-md"
  defp get_parent_classes("lg"), do: "h-4 rounded-lg"
  defp get_parent_classes("xl"), do: "h-5 rounded-xl"

  defp get_parent_color_classes("primary"), do: "bg-primary-100"
  defp get_parent_color_classes("secondary"), do: "bg-secondary-100"
  defp get_parent_color_classes("info"), do: "bg-blue-100"
  defp get_parent_color_classes("success"), do: "bg-green-100"
  defp get_parent_color_classes("warning"), do: "bg-yellow-100"
  defp get_parent_color_classes("danger"), do: "bg-red-100"
  defp get_parent_color_classes("gray"), do: "bg-gray-100"
end
