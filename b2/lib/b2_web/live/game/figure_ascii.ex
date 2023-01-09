defmodule B2Web.Live.Game.FigureAscii do
  use B2Web, :live_component

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="figure">
    <pre>
      <%= B2Web.Live.Game.FigureFor.figure_for(@tally.turns_left) %>
    </pre>
    </div>
    """
  end

  defp hide_if_left_gt(left, level) do
    if left > level, do: "hide-component", else: ""
  end
end
