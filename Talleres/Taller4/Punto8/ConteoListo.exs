defmodule ConteoLista do
  def contar([]), do: 0
  def contar([_ | t]), do: 1 + contar(t)

  def main do
    IO.inspect(contar([1,2,3,4]))
  end
end

ConteoLista.main()
