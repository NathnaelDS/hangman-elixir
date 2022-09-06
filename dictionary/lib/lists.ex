defmodule Pat do
  def samesies(a, a), do: true
  def samesies(_, _), do: false
end

defmodule Lists do
  def len([]), do: 0
  def len([_h | t]), do: 1 + len(t)

  def sum([]), do: 0
  def sum([h | t]), do: h + sum(t)

  def double([]), do: []
  def double([h | t]), do: [h * 2 | double(t)]

  def square([]), do: []
  def square([h | t]), do: [h ** 2 | square(t)]

  def sum_pairs([]), do: []
  def sum_pairs([h1, h2 | t]), do: [h1 + h2 | sum_pairs(t)]

  def even_length?([]), do: true
  def even_length?([_h1, _h2 | t]), do: even_length?(t)
  def even_length?([_h1]), do: false
end
