defmodule Viajante do
  @distancias [
    [0,  8, 15, 21],
    [9,  0, 18, 30],
    [14, 16, 0, 22],
    [20, 29, 17, 0]
  ]

  def resolver() do
    todas = Enum.to_list(0..(length(@distancias) - 1))
    {mejor_camino_final, mejor_distancia_final} =
      Enum.reduce(todas, {[], :infinity}, fn inicio, {mejor_camino_global, mejor_dist_global} ->
        restantes = List.delete(todas, inicio)
        {camino, dist} = backtrack([inicio], restantes, 0, :infinity)
        if dist < mejor_dist_global do
          {camino, dist}
        else
          {mejor_camino_global, mejor_dist_global}
        end
      end)

    IO.puts("Mejor ruta iniciando en cualquier ciudad: #{inspect(mejor_camino_final ++ [hd(mejor_camino_final)])}")
    IO.puts("Distancia mínima: #{mejor_distancia_final}")
  end

  defp backtrack(actual_camino, [], distancia_actual, mejor_distancia) do
    inicio = hd(actual_camino)
    distancia_total = distancia_actual + d(List.last(actual_camino), inicio)
    IO.puts("Ruta posible: #{inspect(actual_camino ++ [inicio])} | Distancia: #{distancia_total}")
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
