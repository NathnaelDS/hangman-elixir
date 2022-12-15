defmodule MemoryWeb.Live.MemoryDisplay do
  use MemoryWeb, :live_view

  def mount(_params, _session, socket) do
    if connected?(socket) do
      wake_me_up()
    end

    {:ok, add_stats_to(socket)}
  end

  def handle_info(:tick, socket) do
    wake_me_up()
    {:noreply, add_stats_to(socket)}
  end

  defp wake_me_up do
    Process.send_after(self(), :tick, 1000)
  end

  defp add_stats_to(socket) do
    socket
    |> assign(%{time: Time.utc_now() |> Time.truncate(:second), memory: :erlang.memory()})
  end

  def render(assigns) do
    ~L"""
    <h1 style="font-size: 148px; text-align: center; color: brown;"><code><%= assigns.time %></code></h1>
    <table>
    <%= for { name, value } <-  assigns.memory do %>
      <tr>
        <th><%= name %></th>
        <td><%= value %></td>
      </tr>
      <% end %>
    </table>
    """
  end
end
