defmodule MapRecursivo do
  def map([], _f), do: []
  def map([h | t], f), do: [f.(h) | map(t, f)]

  def main do
    IO.inspect(map([1,2,3], fn x -> x*3 end))
  end
end

MapRecursivo.main()
