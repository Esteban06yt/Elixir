defmodule EliminarPrimera do
  def eliminar([], _), do: []
  def eliminar([h | t], n) when h == n, do: t
  def eliminar([h | t], n), do: [h | eliminar(t, n)]

  def main do
    IO.inspect(eliminar([1,2,3,2,4], 2))
  end
end

EliminarPrimera.main()
