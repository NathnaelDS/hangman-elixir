defmodule TextClient.Runtime.RemoteHangman do
  @remote_server :"hangman@LAPTOP-9MK3MM8U"

  def connect() do
    :rpc.call(@remote_server, Hangman, :new_game, [])
  end
end
