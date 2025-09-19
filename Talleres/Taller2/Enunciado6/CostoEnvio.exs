defmodule CostoEnvio do
  def main do
    cliente =
      "Ingrese el nombre del cliente: "
      |> Util.ingresar(:texto)

    peso =
      "Ingrese el peso del paquete en kg: "
      |> Util.ingresar(:real)

    tipo_envio =
      "Ingrese el tipo de envío (Economico, Express, Internacional): "
      |> Util.ingresar(:texto)
      |> String.capitalize()

    costo_total = calcular_costo(peso, tipo_envio)

    generar_mensaje({cliente, peso, tipo_envio, costo_total})
    |> Util.mostrar_mensaje()
  end

  defp calcular_costo(peso, tipo_envio) do
    case tipo_envio do
      "Economico" ->
        peso * 5000

      "Express" ->
        peso * 8000

      "Internacional" ->
        cond do
          peso <= 5 -> peso * 15000
          peso > 5 -> peso * 12000
        end

      _ ->
        0
    end
  end

  def generar_mensaje({cliente, peso, tipo_envio, costo_total}) do
    costo_total = costo_total * 1.0 |> Float.round(2)

    if costo_total > 0 do
      "El cliente #{cliente} enviará un paquete de #{peso} kg por #{tipo_envio}, con un costo total de $#{costo_total}."
    else
      "Tipo de envío no válido, no se pudo calcular el costo."
    end
  end
end

CostoEnvio.main()
