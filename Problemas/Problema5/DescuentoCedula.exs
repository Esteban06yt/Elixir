defmodule DescuentoCedula do
  def main do
    cedula =
      "Ingrese el número de cédula del cliente: "
      |> Util.ingresar(:entero)

    verificar_descuento(cedula)
  end

  def verificar_descuento(nil) do
    Util.mostrar_mensaje("No se ingresó una cédula válida.")
  end

  def verificar_descuento(cedula) do
    if rem(cedula, 1991) == 0 do
      Util.mostrar_mensaje(
        "El cliente con cédula #{cedula} SÍ recibe el descuento del 50%."
      )
    else
      Util.mostrar_mensaje(
        "El cliente con cédula #{cedula} NO recibe el descuento."
      )
    end
  end
end

DescuentoCedula.main()
