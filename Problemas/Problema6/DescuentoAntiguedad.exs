defmodule DescuentoAntiguedad do
  def main do
    antiguedad =
      "Ingrese la antigüedad del cliente en años: "
      |> Util.ingresar(:entero)

    verificar_descuento(antiguedad)
  end

  def verificar_descuento(nil) do
    Util.mostrar_mensaje("No se ingresó una antigüedad válida.")
  end

  def verificar_descuento(antiguedad) when antiguedad < 1 do
    Util.mostrar_mensaje(
      "El cliente no recibe descuento por tener menos de 1 año."
    )
  end

  def verificar_descuento(antiguedad) when antiguedad >= 1 and antiguedad <= 2 do
    Util.mostrar_mensaje(
      "El cliente con #{antiguedad} años recibe un 10% de descuento."
    )
  end

  def verificar_descuento(antiguedad) when antiguedad >= 3 and antiguedad <= 6 do
    Util.mostrar_mensaje(
      "El cliente con #{antiguedad} años recibe un 14% de descuento."
    )
  end

  def verificar_descuento(antiguedad) when antiguedad > 6 do
    Util.mostrar_mensaje(
      "El cliente con #{antiguedad} años recibe un 17% de descuento."
    )
  end
end

DescuentoAntiguedad.main()
