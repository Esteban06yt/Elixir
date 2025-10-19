defmodule Viajante do
  @distancias [
    [0,  8, 15, 21],
    [9,  0, 18, 30],
    [14, 16, 0, 22],
    [20, 29, 17, 0]
  ]

  def resolver() do
    ciudades = Enum.to_list(1..(length(@distancias) - 1))
    {camino, distancia} = backtrack([0], ciudades, 0, :infinity)
    IO.puts("Mejor ruta: #{inspect(camino ++ [0])}")
    IO.puts("Distancia mínima: #{distancia}")
  end

  defp backtrack(actual_camino, [], distancia_actual, mejor_distancia) do
    distancia_total = distancia_actual + d(List.last(actual_camino), 0)
    IO.puts("Ruta posible: #{inspect(actual_camino ++ [0])} | Distancia: #{distancia_total}")
    if distancia_total < mejor_distancia do
      {actual_camino, distancia_total}
    else
      {[], mejor_distancia}
    end
  end

  defp backtrack(actual_camino, restantes, distancia_actual, mejor_distancia) do
    Enum.reduce(restantes, {[], mejor_distancia}, fn ciudad, {mejor_camino, mejor_dist} ->
      nueva_dist = distancia_actual + d(List.last(actual_camino), ciudad)
      {camino, dist} =
        backtrack(
          actual_camino ++ [ciudad],
          List.delete(restantes, ciudad),
          nueva_dist,
          mejor_dist
        )
      if dist < mejor_dist do
        {camino, dist}
      else
        {mejor_camino, mejor_dist}
      end
    end)
  end

  defp d(i, j), do: Enum.at(Enum.at(@distancias, i), j)
end

Viajante.resolver()
