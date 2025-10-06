defmodule SumaObjetivo do
  def combinaciones(lista, objetivo) do
    buscar(lista, objetivo, [])
  end

  defp buscar(_, 0, combinacion), do: [Enum.reverse(combinacion)]

  defp buscar([], _objetivo, _combinacion), do: []

  defp buscar([cabeza | cola], objetivo, combinacion) do
    con_actual =
      buscar(cola, objetivo - cabeza, [cabeza | combinacion])

    sin_actual =
      buscar(cola, objetivo, combinacion)

    con_actual ++ sin_actual
  end
end

lista = [1, 2, 3, 4, 5, 6, 7, 8, 9]
objetivo = 10

resultado = SumaObjetivo.combinaciones(lista, objetivo)

if resultado == [] do
  IO.puts("No se encontraron combinaciones que sumen #{objetivo}.")
else
  IO.puts("Combinaciones encontradas que suman #{objetivo}:")
  Enum.each(resultado, &IO.inspect/1)
end
