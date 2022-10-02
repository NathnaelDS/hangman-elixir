defmodule Procs do
  def hello(count) do
    receive do
      {:reset} ->
        hello(0)

      msg ->
        IO.puts("#{count}: Hi, #{msg}")
        hello(count + 1)
    end
  end
end
