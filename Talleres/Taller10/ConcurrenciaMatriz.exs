defmodule ConcurrenciaMatriz do
  def main do
    matriz = [
      [1,2,3],
      [4,5,6],
      [7,8,9]
    ]

    t1 = Task.async(fn -> suma_debajo_diagonal(matriz) end)
    t2 = Task.async(fn -> promedio_encima_diagonal(matriz) end)

    a = Task.await(t1)
    b = Task.await(t2)

    c = a * b
    IO.puts("Suma bajo bajo la diagonal = #{a}")
    IO.puts("Promedio sobre la diagonal = #{b}")
    IO.puts("Resultado (c = a * b): #{c}")

  end

  def suma_debajo_diagonal(matriz) do
    suma_debajo_diagonal(matriz, 0, 0)
  end
  defp suma_debajo_diagonal([], _, _), do: 0
  defp suma_debajo_diagonal([fila | resto], fila_indice, _) do
    suma_fila =
      fila
      |> Enum.with_index()
      |> Enum.reduce(0, fn {valor, col_indice}, acc ->
        if col_indice < fila_indice, do: acc + valor, else: acc
      end)

    suma_fila + suma_debajo_diagonal(resto, fila_indice + 1, 0)
  end

  def promedio_encima_diagonal(matriz) do
    {suma, cantidad} =
      matriz
      |> Enum.with_index()
      |> Enum.reduce({0, 0}, fn {fila, fila_indice}, {acum, cont} ->
        fila
        |> Enum.with_index()
        |> Enum.reduce({acum, cont}, fn {valor, col_indice}, {a, c} ->
          if col_indice > fila_indice, do: {a + valor, c + 1}, else: {a, c}
        end)
      end)

    if cantidad == 0, do: 0, else: suma / cantidad
  end
end

ConcurrenciaMatriz.main()
