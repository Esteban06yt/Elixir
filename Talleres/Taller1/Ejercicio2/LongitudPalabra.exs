defmodule LongitudPalabra do
  def main do
    palabra =
      "Digite una palabra: "
      |> Util.ingresar(:texto)

    longitud = String.length(palabra)

    generar_mensaje(palabra, longitud)
    |> Util.mostrar_mensaje()
  end

  defp generar_mensaje(palabra, longitud) do
    "La palabra '#{palabra}' tiene #{longitud} letras."
  end
end

LongitudPalabra.main()
