defmodule MensajeMayusculas do
  def main do
    mensaje =
      "Digite un mensaje: "
      |> Util.ingresar(:texto)

    mensaje
    |> String.upcase()
    |> Util.mostrar_mensaje()
  end
end

MensajeMayusculas.main()
