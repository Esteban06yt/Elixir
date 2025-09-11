defmodule ConsumoCombustible do
  def main do
    nombre =
      "Digite el nombre del conductor: "
      |> Util.ingresar(:texto)

    distancia =
      "Digite la distancia recorrida en kilómetros: "
      |> Util.ingresar(:real)

    litros =
      "Digite la cantidad de combustible consumido en litros: "
      |> Util.ingresar(:real)

    rendimiento = calcular_rendimiento(distancia, litros)

    generar_mensaje(nombre, rendimiento)
    |> Util.mostrar_mensaje()
  end

  defp calcular_rendimiento(distancia, litros) do
    distancia / litros
  end

  def generar_mensaje(nombre, rendimiento) do
    rendimiento = Float.round(rendimiento, 2)
    "El rendimiento del vehículo de #{nombre} es: #{rendimiento} km/L"
  end
end

ConsumoCombustible.main()
