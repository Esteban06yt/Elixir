defmodule RegistroPeaje do
  def main do
    placa =
      "Ingrese la placa del vehículo: "
      |> Util.ingresar(:texto)

    tipo =
      "Ingrese el tipo de vehículo (Carro, Moto, Camion): "
      |> Util.ingresar(:texto)
      |> String.capitalize()

    peso =
      "Ingrese el peso del vehículo en toneladas: "
      |> Util.ingresar(:real)

    tarifa_final = calcular_tarifa(tipo, peso)

    generar_mensaje({placa, tipo, tarifa_final})
    |> Util.mostrar_mensaje()
  end

  defp calcular_tarifa("Carro", _peso), do: 10000
  defp calcular_tarifa("Moto", _peso), do: 5000

  defp calcular_tarifa("Camion", peso) do
    # Tarifa base 20,000 + 2,000 por cada tonelada adicional
    20000 + (peso * 2000)
  end

  defp calcular_tarifa(_, _), do: 0  # en caso de tipo no válido

  def generar_mensaje({placa, tipo, tarifa}) do
    tarifa = tarifa * 1.0 |> Float.round(2)
    "Vehículo #{placa} (#{tipo}) debe pagar $#{tarifa}."
  end
end

RegistroPeaje.main()
