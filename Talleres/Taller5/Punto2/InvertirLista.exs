defmodule InvertirLista do
  def invertir([]), do: []

  def invertir([cabeza | cola]) do
    invertir(cola) ++ [cabeza]
  end
end

IO.inspect(InvertirLista.invertir([1, 2, 3, 4, 5]))
