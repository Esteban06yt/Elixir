defmodule TransposicionMatriz do
  def transponer([]), do: []
  def transponer([[] | _]), do: []

  def transponer(matriz) do
    primera_columna = tomar_primera_columna(matriz)

    resto = quitar_primera_columna(matriz)

    [primera_columna | transponer(resto)]
  end

  defp tomar_primera_columna([]), do: []
  defp tomar_primera_columna([[x | _] | resto]), do: [x | tomar_primera_columna(resto)]

  defp quitar_primera_columna([]), do: []
  defp quitar_primera_columna([[ _ | xs] | resto]), do: [xs | quitar_primera_columna(resto)]
end

matriz = [
  [1, 2, 3, 4],
  [5, 6, 7, 8],
  [9, 10, 11, 12],
  [13, 14, 15, 16]
]

IO.inspect(TransposicionMatriz.transponer(matriz))
