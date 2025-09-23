defmodule Ventas do
  def analizar_ventas(ventas) do
    case ventas do
      %{} when map_size(ventas) == 0 ->
        {0, 0, "No hay datos"}
      _ ->
        total = ventas |> Map.values() |> Enum.sum()
        promedio = total / map_size(ventas)
        {dia_mejor, _} = Enum.max_by(ventas, fn {_dia, venta} -> venta end)
        {total, promedio, dia_mejor}
    end
  end

  def main do
    ventas = %{1 => 100, 2 => 200, 3 => 50, 4 => 300}
    IO.inspect(analizar_ventas(ventas))
    IO.inspect(analizar_ventas(%{}))
  end
end

Ventas.main()
