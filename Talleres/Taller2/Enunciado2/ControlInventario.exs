defmodule ControlInventario do
  def main do
    titulo =
      "Ingrese el título del libro: "
      |> Util.ingresar(:texto)

    cantidad =
      "Ingrese la cantidad de unidades disponibles: "
      |> Util.ingresar(:entero)

    precio_unitario =
      "Ingrese el precio unitario: "
      |> Util.ingresar(:real)

    valor_total = calcular_valor_total(cantidad, precio_unitario)

    generar_mensaje(titulo, cantidad, valor_total)
    |> Util.mostrar_mensaje()
  end

  defp calcular_valor_total(cantidad, precio_unitario) do
    cantidad * precio_unitario
  end

  def generar_mensaje(titulo, cantidad, valor_total) do
    valor_total = Float.round(valor_total, 2)
    "El libro \"#{titulo}\" tiene #{cantidad} unidades, con un valor total de $#{valor_total}."
  end
end

ControlInventario.main()
