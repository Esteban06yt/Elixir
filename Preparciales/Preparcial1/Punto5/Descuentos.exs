defmodule Descuentos do
  def calcular_descuentos([], _porcentaje), do: {[], 0}

  def calcular_descuentos(productos, porcentaje) do
    lista_descuentos =
      Enum.map(productos, fn {nombre, precio} ->
        descuento = precio * (porcentaje / 100)
        nuevo_precio = precio - descuento
        {nombre, nuevo_precio}
      end)

    total_descuento =
      Enum.map(productos, fn {_nombre, precio} ->
        precio * (porcentaje / 100)
      end)
      |> Enum.sum()

    {lista_descuentos, total_descuento}
  end

  def main do
    productos = [{"Laptop", 3000}, {"Mouse", 100}, {"Teclado", 200}]
    IO.inspect(calcular_descuentos(productos, 10))
    IO.inspect(calcular_descuentos([], 10))
  end
end

Descuentos.main()
