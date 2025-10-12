defmodule MaxLista do
  def maximo([x]), do: x
  def maximo([h | t]) do
    max_t = maximo(t)
    if h > max_t, do: h, else: max_t
  end

  def main do
    IO.inspect(maximo([3,7,2,9,1]))
  end
end

MaxLista.main()
