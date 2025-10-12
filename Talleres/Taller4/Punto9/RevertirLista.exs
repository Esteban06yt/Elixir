defmodule RevertirLista do
  def revertir([]), do: []
  def revertir([h | t]), do: revertir(t) ++ [h]

  def main do
    IO.inspect(revertir([1,2,3,4]))
  end
end

RevertirLista.main()
