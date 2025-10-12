defmodule DuplicarLista do
  def duplicar([]), do: []
  def duplicar([h | t]), do: [h*2 | duplicar(t)]

  def main do
    IO.inspect(duplicar([1,2,3]))
  end
end

DuplicarLista.main()
