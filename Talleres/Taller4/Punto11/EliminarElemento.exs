defmodule EliminarElemento do
  def eliminar([], _), do: []
  def eliminar([h | t], n) when h == n, do: eliminar(t, n)
  def eliminar([h | t], n), do: [h | eliminar(t, n)]

  def main do
    IO.inspect(eliminar([1,2,3,4,2], 2))
  end
end

EliminarElemento.main()
