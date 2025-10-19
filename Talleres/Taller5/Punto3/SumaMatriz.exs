defmodule SumaMatriz do
  def sumar([]), do: 0

  def sumar([fila | resto]) do
    sumar_fila(fila) + sumar(resto)
  end

  defp sumar_fila([]), do: 0

  defp sumar_fila([cabeza | cola]) do
    cabeza + sumar_fila(cola)
  end
end

matriz = [
  [1, 2, 3, 4],
  [5, 6, 7, 8],
  [9, 10, 11, 12],
  [13, 14, 15, 16]
]

IO.puts(SumaMatriz.sumar(matriz))
