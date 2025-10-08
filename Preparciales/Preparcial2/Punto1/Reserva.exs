defmodule Reserva do
  def main do
    Util.mostrar_mensaje("=== SISTEMA DE RESERVAS HOTELERAS ===")
    reserva = Reserva.nueva_reserva()
    Reserva.guardar_en_csv(reserva)
  end

  def nueva_reserva do
    codigo = Util.ingresar("Código de la reserva: ", :texto)
    fecha_reserva = Util.ingresar("Fecha de la reserva (YYYY-MM-DD): ", :texto)
    fecha_entrada = Util.ingresar("Fecha de entrada (YYYY-MM-DD): ", :texto)
    total = Util.ingresar("Total de la reserva: ", :real)
    tipo_habitacion = Util.ingresar("Tipo de habitación (sencilla/doble): ", :texto)
    cliente = Util.ingresar("Nombre del cliente: ", :texto)

    habitaciones = ingresar_habitaciones([])

    %{
      codigo: codigo,
      fecha_reserva: fecha_reserva,
      fecha_entrada: fecha_entrada,
      total: total,
      tipo_habitacion: tipo_habitacion,
      cliente: cliente,
      habitaciones: habitaciones
    }
  end

  defp ingresar_habitaciones(lista) do
    numero = Util.ingresar("Número de habitación: ", :entero)
    tipo = Util.ingresar("Tipo de habitación: ", :texto)

    nueva = %{numero: numero, tipo: tipo}
    continuar = Util.ingresar("¿Desea agregar otra habitación? (s/n): ", :texto)

    if String.downcase(continuar) == "s" do
      ingresar_habitaciones([nueva | lista])
    else
      Enum.reverse([nueva | lista])
    end
  end

  def guardar_en_csv(reserva) do
    linea =
      [
        reserva.codigo,
        reserva.fecha_reserva,
        reserva.fecha_entrada,
        Float.to_string(reserva.total),
        reserva.tipo_habitacion,
        reserva.cliente,
        formatear_habitaciones(reserva.habitaciones)
      ]
      |> Enum.join(",")

    File.write("reservas.csv", linea <> "\n", [:append])
    Util.mostrar_mensaje("Reserva guardada correctamente.")
  end

  defp formatear_habitaciones(habitaciones) do
    habitaciones
    |> Enum.map(fn h -> "#{h.numero}-#{h.tipo}" end)
    |> Enum.join("|")
  end
end

Reserva.main()
