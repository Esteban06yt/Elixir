defmodule ContarApariciones do
  def contar([], _), do: 0
  def contar([h | t], n) when h == n, do: 1 + contar(t, n)
  def contar([_ | t], n), do: contar(t, n)

  def main do
    IO.inspect(contar([1,2,3,2,2,4], 2))
  end
end

ContarApariciones.main()
