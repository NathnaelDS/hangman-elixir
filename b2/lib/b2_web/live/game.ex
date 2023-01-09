defmodule B2Web.Live.Game do
  use B2Web, :live_view

  def mount(_params, _session, socket) do
    game = Hangman.new_game()
    tally = Hangman.tally(game)
    socket = socket |> assign(%{game: game, tally: tally, mode: :graphic_ui})
    {:ok, socket}
  end

  def handle_event("make_move", %{"key" => key}, socket) do
    tally = Hangman.make_move(socket.assigns.game, key)
    {:noreply, assign(socket, :tally, tally)}
  end

  def handle_event("toggle", a, %{assigns: %{mode: mode = :graphic_ui} = assigns} = socket) do
    {:noreply, assign(socket, :mode, :text_ui) |> IO.inspect()}
  end

  def handle_event("toggle", a, %{assigns: %{mode: mode = :text_ui} = assigns} = socket) do
    {:noreply, assign(socket, :mode, :graphic_ui) |> IO.inspect()}
  end

  def render(assigns) do
    ~L"""
      <button phx-click="toggle">Toggle</button>

      <div class="game-holder" phx-window-keyup="make_move" :if={{@assigns.mode == :graphic_ui}}>
        <%= if @mode == :graphic_ui do %>
          <%= live_component(__MODULE__.Figure,    tally: assigns.tally, id: 1 ) %>
        <% else %>
          <%= live_component(__MODULE__.FigureAscii,    tally: assigns.tally, id: 4 ) %>
        <% end %>

        <%= live_component(__MODULE__.Alphabet,  tally: assigns.tally, id: 2 ) %>
        <%= live_component(__MODULE__.WordSoFar, tally: assigns.tally, id: 3 ) %>
      </div>
    """
  end
end
