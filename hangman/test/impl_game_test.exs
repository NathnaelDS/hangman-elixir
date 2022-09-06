defmodule HangmanImplGameTest do
  use ExUnit.Case

  alias Hangman.Impl.Game

  test "new game returns structure" do
    game = Game.new_game()
    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
  end

  test "new game returns correct word" do
    game = Game.new_game("phantom")
    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert game.letters == ["p", "h", "a", "n", "t", "o", "m"]
  end

  test "each letter returned from new game is lowercase" do
    game = Game.new_game()
    assert game.letters == Enum.map(game.letters, fn x -> String.downcase(x) end)
  end

  test "state doesn't change if a game is won or lost" do
    for state <- [:won, :lost] do
      game = Game.new_game("punish")
      game = Map.put(game, :game_state, state)
      {new_game, _tally} = Game.make_move(game, "x")
      assert new_game == game
    end
  end
end
