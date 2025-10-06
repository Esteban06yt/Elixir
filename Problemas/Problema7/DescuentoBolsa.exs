defmodule DescuentoBolsa do
  def main do
    tipo_bolsa =
      "Ingrese el tipo de bolsa del cliente (plastica, biodegradable, reutilizable): "
      |> Util.ingresar(:texto)
      |> String.downcase()

    verificar_descuento(tipo_bolsa)
  end

  def verificar_descuento(nil) do
    Util.mostrar_mensaje("No se ingresó un tipo de bolsa válido.")
  end

  def verificar_descuento("plastica") do
    Util.mostrar_mensaje("El cliente recibe un 2% de descuento.")
  end

  def verificar_descuento("biodegradable") do
    Util.mostrar_mensaje("El cliente recibe un 12% de descuento.")
  end

  def verificar_descuento("reutilizable") do
    Util.mostrar_mensaje("El cliente recibe un 17% de descuento.")
  end

  def verificar_descuento(_otro) do
    Util.mostrar_mensaje(
      "El cliente no recibe descuento por ese tipo de bolsa o contenedor."
    )
  end
end

DescuentoBolsa.main()
