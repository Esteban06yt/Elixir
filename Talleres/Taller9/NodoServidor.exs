defmodule NodoServidor do
  @nombre_servicio_local :servicio_cadenas
  @autores_file "autores.csv"
  @trabajos_file "trabajos.csv"

  def main() do
    Util.mostrar_mensaje("PROCESO SECUNDARIO - Iniciando servidor de Trabajos de Grado")
    registrar_servicio(@nombre_servicio_local)
    autores = cargar_autores(@autores_file)
    trabajos = cargar_trabajos(@trabajos_file)
    Util.mostrar_mensaje("Datos cargados: #{map_size(autores)} autores, #{length(trabajos)} trabajos.")
    procesar_mensajes(%{autores: autores, trabajos: trabajos})
  end

  defp registrar_servicio(nombre_servicio_local),
    do: Process.register(self(), nombre_servicio_local)

  # Loop principal con estado (autores y trabajos)
  defp procesar_mensajes(state) do
    receive do
      {productor, {:list_trabajos}} ->
        # enviar sólo resumen (id, fecha, titulo)
        trabajos_resumen = Enum.map(state.trabajos, fn t ->
          %{id: t.id, fecha: t.fecha, titulo: t.titulo}
        end)
        send(productor, {:trabajos_list, trabajos_resumen})
        procesar_mensajes(state)

      {productor, {:autores_por_trabajo, identificador}} ->
        respuesta =
          case buscar_trabajo(state.trabajos, identificador) do
            nil ->
              {:error, "Trabajo no encontrado con '#{identificador}'."}
            trabajo ->
              autores =
                trabajo.autores
                |> Enum.map(fn cedula -> Map.get(state.autores, cedula) end)
                |> Enum.filter(& &1) # eliminar nil si hay inconsistencias
              {:autores_list, trabajo, autores}
          end

        send(productor, respuesta)
        procesar_mensajes(state)

      {productor, :fin} ->
        send(productor, :fin)
        :ok

      other ->
        # mensajes desconocidos
        IO.puts("Servidor: mensaje desconocido recibido: #{inspect(other)}")
        procesar_mensajes(state)
    end
  end

  # Buscar trabajo por id o por título (coincidencia exacta o por índice)
  defp buscar_trabajo(trabajos, identificador) when is_integer(identificador) do
    Enum.at(trabajos, identificador)
  end

  defp buscar_trabajo(trabajos, identificador) do
    # probar id exacto string
    found = Enum.find(trabajos, fn t -> t.id == to_string(identificador) end)
    if found, do: found, else:
      Enum.find(trabajos, fn t -> String.downcase(t.titulo) == String.downcase(to_string(identificador)) end)
  end

  # CARGA CSV
  defp cargar_autores(path) do
    path
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.drop(1) # quitar header
    |> Enum.map(&String.trim/1)
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(fn line ->
      [cedula, nombre, apellidos, programa_academico, titulo_profesional] =
        line |> String.split(",", trim: true)
      {cedula, %{
        cedula: cedula,
        nombre: nombre,
        apellidos: apellidos,
        programa_academico: programa_academico,
        titulo_profesional: titulo_profesional
      }}
    end)
    |> Enum.into(%{})
  end

  defp cargar_trabajos(path) do
    path
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.drop(1)
    |> Enum.map(&String.trim/1)
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(fn line ->
      # id,fecha,titulo,descripcion,autores (cedulas separadas por |)
      # NOTA: si la descripcion o título contienen comas, esto simple split fallará.
      parts = String.split(line, ",", trim: true)
      # asumir formato correcto (5 columnas)
      [id, fecha, titulo, descripcion, autores_str] = parts
      autores = autores_str |> String.split("|", trim: true)
      %{
        id: id,
        fecha: fecha,
        titulo: titulo,
        descripcion: descripcion,
        autores: autores
      }
    end)
  end
end

NodoServidor.main()
