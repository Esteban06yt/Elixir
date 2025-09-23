defmodule Ejercicio1 do
  def punto_a do
    x = [1, 2, 3, 4, 5]
    Enum.reduce(x, %{total: 0, count: 0}, fn el, acc ->
      %{acc | total: acc.total + el, count: acc.count + 1}
    end)
  end

  def punto_b do
    Enum.reduce([2, 4, 6, 8], 2, fn (x, acc) -> x + acc end)
  end

  def punto_c do
    defmodule Tuplas do
      def analizar_tupla({a, b}) when is_integer(a) and is_integer(b), do: a * b
      def analizar_tupla(_), do: "Formato incorrecto"
    end
    {Tuplas.analizar_tupla({4, 5}), Tuplas.analizar_tupla({4, "hola"})}
  end

  def punto_d do
    lista = [1, 2, 3, 4]
    Enum.reduce(lista, 10, fn x, acc -> acc + x end)
  end

  def punto_e do
    list = [1, 2, 3]
    Enum.map(list, fn x -> x * 2 end)
  end

  def main do
    IO.inspect(punto_a())
    IO.inspect(punto_b())
    IO.inspect(punto_c())
    IO.inspect(punto_d())
    IO.inspect(punto_e())
  end
end

Ejercicio1.main()
