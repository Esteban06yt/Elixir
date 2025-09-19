defmodule CostoEnvioCliente do
  def main do
    peso =
      "Ingrese el peso del paquete en kg: "
      |> Util.ingresar(:real)

    tipo_cliente =
      "Ingrese el tipo de cliente (1=corporativo, 2=estudiante, 3=regular): "
      |> Util.ingresar(:entero)
      |> cliente_atom()

    servicio =
      "Ingrese el tipo de servicio (1=express, 2=estandar): "
      |> Util.ingresar(:entero)
      |> servicio_atom()

    if peso > 0 do
      base = tarifa_base(peso)
      descuento = calcular_descuento(base, tipo_cliente)
      subtotal = base - descuento
      recargo = calcular_recargo(subtotal, servicio)
      total = subtotal + recargo

      generar_mensaje(base, descuento, subtotal, recargo, total)
      |> Util.mostrar_mensaje()
    else
      "Error: el peso debe ser mayor a 0 kg."
      |> Util.mostrar_mensaje()
    end
  end

  defp tarifa_base(peso) do
    cond do
      peso <= 1 -> 8000
      peso <= 5 -> 12000
      peso > 5 -> 20000
    end
  end

  defp calcular_descuento(base, :corporativo), do: base * 0.15
  defp calcular_descuento(base, :estudiante), do: base * 0.10
  defp calcular_descuento(base, :regular), do: 0

  defp calcular_recargo(subtotal, :express), do: subtotal * 0.25
  defp calcular_recargo(_subtotal, :estandar), do: 0

  defp cliente_atom(1), do: :corporativo
  defp cliente_atom(2), do: :estudiante
  defp cliente_atom(3), do: :regular
  defp cliente_atom(_), do: :regular

  defp servicio_atom(1), do: :express
  defp servicio_atom(2), do: :estandar
  defp servicio_atom(_), do: :estandar

  def generar_mensaje(base, descuento, subtotal, recargo, total) do
    base = base * 1.0 |> Float.round(2)
    descuento = descuento * 1.0 |> Float.round(2)
    subtotal = subtotal * 1.0 |> Float.round(2)
    recargo = recargo * 1.0 |> Float.round(2)
    total = total * 1.0 |> Float.round(2)

    """
    Desglose del costo de envío:
    - Tarifa base: $#{trunc(base)}
    - Descuento: $#{trunc(descuento)}
    - Subtotal: $#{trunc(subtotal)}
    - Recargo: $#{trunc(recargo)}
    - Total a pagar: $#{trunc(total)}
    """
  end
end

CostoEnvioCliente.main()
