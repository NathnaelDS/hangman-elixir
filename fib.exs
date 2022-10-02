defmodule FibAgent do
  def start() do
    Agent.start_link(fn -> %{0 => 0, 1 => 1} end)
  end

  def fib(n, agent) do
    cache = Agent.get(agent, fn state -> state end)
    check_cache(cache[n], n, agent)
  end

  def check_cache(nil, n, agent) do
    new_value = fib(n - 1, agent) + fib(n - 2, agent)

    Agent.get_and_update(agent, fn state -> {new_value, Map.put(state, n, new_value)} end)
    |> IO.inspect()
  end

  def check_cache(value, _n, _agent) do
    value
  end
end
