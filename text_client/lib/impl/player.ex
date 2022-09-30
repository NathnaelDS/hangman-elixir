defmodule TextClient.Impl.Player do
  @typep game :: Hangman.game()
  @typep tally :: Hangman.Type.tally()
  @typep state :: {game, tally}

  @spec start() :: :ok
  def start() do
    game = Hangman.new_game()
    tally = Hangman.tally(game)
    interact({game, tally})
  end

  @spec interact(state) :: :ok

  def interact({_game, _tally = %{game_state: :won}}) do
    IO.puts("Congratulations. You won!")
  end

  def interact({_game, tally = %{game_state: :lost}}) do
    IO.puts("Sorry, you lost... the word was #{tally.letters |> Enum.join()}")
  end

  def interact({game, tally}) do
    # feedback
    IO.puts(feedback_for(tally))

    # display the current word
    IO.puts(IO.ANSI.format([:blue_background, current_word(tally)]))

    # get next guess
    user_input = IO.gets("Next guess: ") |> String.trim() |> String.downcase()

    # make move
    {updated_game, updated_tally} = Hangman.make_move(game, user_input)

    IO.puts("...")
    interact({updated_game, updated_tally})
  end

  def feedback_for(tally = %{game_state: :initializing}) do
    "Welcome! I'm thinking of a #{tally.letters |> length} letter word"
  end

  def feedback_for(%{game_state: :good_guess}), do: "Good guess!"
  def feedback_for(%{game_state: :bad_guess}), do: "Sorry, that letter is not in the word"
  def feedback_for(%{game_state: :already_used}), do: "You already used that letter"

  def current_word(tally) do
    [
      IO.ANSI.blue() <> "Word so far: " <> IO.ANSI.reset(),
      tally.letters |> Enum.join(" "),
      IO.ANSI.blue() <> "   turns left: " <> IO.ANSI.reset(),
      tally.turns_left |> to_string,
      IO.ANSI.blue() <> "   used so far: " <> IO.ANSI.reset(),
      tally.used |> Enum.join(",")
    ]
  end
end
