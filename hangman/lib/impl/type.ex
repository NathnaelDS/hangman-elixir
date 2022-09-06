defmodule Hangman.Type do
  @type tally :: %{
          turns_left: integer,
          game_state: state,
          letters: list(String.t()),
          used: list(String.t())
        }

  @type state :: :initializing | :won | :lost | :good_guess | :bad_guess | :already_used
end
