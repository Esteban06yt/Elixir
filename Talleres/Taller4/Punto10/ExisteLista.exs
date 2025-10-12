defmodule ExisteLista do
  def existe?([], _), do: false
  def existe?([h | t], n) when h == n, do: true
  def existe?([_ | t], n), do: existe?(t, n)

  def main do
    IO.inspect(existe?([1,2,3,4], 3))
  end
end

ExisteLista.main()
