defmodule ConversionTemperatura do
  def main do
    nombre =
      "Ingrese su nombre: "
      |> Util.ingresar(:texto)

    celsius =
      "Ingrese la temperatura en °C: "
      |> Util.ingresar(:real)

    fahrenheit = convertir_a_fahrenheit(celsius)
    kelvin = convertir_a_kelvin(celsius)

    generar_mensaje(nombre, fahrenheit, kelvin)
    |> Util.mostrar_mensaje()
  end

  defp convertir_a_fahrenheit(celsius) do
    (celsius * 9 / 5) + 32
  end

  defp convertir_a_kelvin(celsius) do
    celsius + 273.15
  end

  def generar_mensaje(nombre, fahrenheit, kelvin) do
    fahrenheit = Float.round(fahrenheit, 1)
    kelvin = Float.round(kelvin, 1)

    """
    #{nombre}, la temperatura es:
    - #{fahrenheit} °F
    - #{kelvin} K
    """
  end
end

ConversionTemperatura.main()
