defmodule MinLista do
  def minimo([x]), do: x
  def minimo([h | t]) do
    min_t = minimo(t)
    if h < min_t, do: h, else: min_t
  end

  def main do
    IO.inspect(minimo([4,7,1,9]))
  end
end

MinLista.main()
