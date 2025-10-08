defmodule Reserva do
  def main do
    Util.mostrar_mensaje("=== SISTEMA DE RESERVAS HOTELERAS ===")

    IO.puts("""
    1. Registrar nueva reserva
    2. Consultar reservas por fecha
    3. Salir
    """)

    opcion = Util.ingresar("Seleccione una opción: ", :entero)

    case opcion do
      1 ->
        reserva = Reserva.nueva_reserva()
        Reserva.guardar_en_csv(reserva)
        Util.mostrar_mensaje("Reserva guardada correctamente.")
        main()

      2 ->
        fecha = Util.ingresar("Ingrese la fecha de reserva (YYYY-MM-DD) a consultar: ", :texto)
        Reserva.ConsultaReserva.buscar_por_fecha(fecha)
        main()

      3 ->
        Util.mostrar_mensaje("Saliendo del sistema. ¡Hasta pronto!")

      _ ->
        IO.puts("Opción inválida, intente de nuevo.")
        main()
    end
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
  end

  def formatear_habitaciones(habitaciones) do
    habitaciones
    |> Enum.map(fn h -> "#{h.numero}-#{h.tipo}" end)
    |> Enum.join("|")
  end

  defmodule ConsultaReserva do
    def buscar_por_fecha(fecha) do
      case File.read("reservas.csv") do
        {:ok, contenido} ->
          reservas = parsear_csv(contenido)
          resultado = buscar_dividir(reservas, fecha)

          if resultado == [] do
            IO.puts("No se encontraron reservas con la fecha #{fecha}.")
          else
            IO.puts("Reservas encontradas para la fecha #{fecha}:")
            Enum.each(resultado, &mostrar_reserva/1)
          end

        {:error, _} ->
          IO.puts("No existe el archivo reservas.csv o no se puede leer.")
      end
    end

    defp buscar_dividir([], _fecha), do: []

    defp buscar_dividir([reserva], fecha) do
      if reserva.fecha_reserva == fecha, do: [reserva], else: []
    end

    defp buscar_dividir(lista, fecha) do
      mitad = div(length(lista), 2)
      {izquierda, derecha} = Enum.split(lista, mitad)
      buscar_dividir(izquierda, fecha) ++ buscar_dividir(derecha, fecha)
    end

    defp parsear_csv(contenido) do
      contenido
      |> String.split("\n", trim: true)
      |> Enum.map(fn linea ->
        [codigo, fecha_reserva, fecha_entrada, total, tipo, cliente, habitaciones_str] =
          String.split(linea, ",")

        habitaciones =
          String.split(habitaciones_str, "|", trim: true)
          |> Enum.map(fn h ->
            [num, tipo_h] = String.split(h, "-")
            %{numero: String.to_integer(num), tipo: tipo_h}
          end)

        %{
          codigo: codigo,
          fecha_reserva: fecha_reserva,
          fecha_entrada: fecha_entrada,
          total: String.to_float(total),
          tipo_habitacion: tipo,
          cliente: cliente,
          habitaciones: habitaciones
        }
      end)
    end

    defp mostrar_reserva(reserva) do
      IO.puts("""
      Código: #{reserva.codigo}
      Cliente: #{reserva.cliente}
      Fecha de reserva: #{reserva.fecha_reserva}
      Fecha de entrada: #{reserva.fecha_entrada}
      Tipo: #{reserva.tipo_habitacion}
      Total: #{reserva.total}
      Habitaciones: #{Reserva.formatear_habitaciones(reserva.habitaciones)}
      """)
    end
  end
end

Reserva.main()
