defmodule ProductoLista do
  def producto([]), do: 1
  def producto([h | t]), do: h * producto(t)

  def main do
    IO.inspect(producto([2,3,4]))
  end
end

ProductoLista.main()
