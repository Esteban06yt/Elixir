defmodule NodoCliente do
  @nombre_servicio_local :servicio_respuesta
  @servicio_local {@nombre_servicio_local, :nodocliente@cliente}
  @nodo_remoto :nodoservidor@localhost
  @servicio_remoto {:servicio_cadenas, @nodo_remoto}

  def main() do
    Util.mostrar_mensaje("PROCESO PRINCIPAL - Nodo Cliente iniciando")
    registrar_servicio(@nombre_servicio_local)

    case establecer_conexion(@nodo_remoto) do
      true ->
        pedir_listado_trabajos()
        esperar_y_procesar_interaccion()
      false ->
        Util.mostrar_error("No se pudo conectar con el nodo servidor #{@nodo_remoto}")
    end
  end

  defp registrar_servicio(nombre_servicio_local) do
    Process.register(self(), nombre_servicio_local)
  end

  defp establecer_conexion(nodo_remoto) do
    Node.connect(nodo_remoto)
  end

  defp pedir_listado_trabajos() do
    send(@servicio_remoto, {@servicio_local, {:list_trabajos}})
  end

  defp esperar_y_procesar_interaccion() do
    receive do
      {:trabajos_list, trabajos} ->
        mostrar_trabajos(trabajos)
        seleccionar_trabajo_y_pedir_autores(trabajos)

      {:error, msg} ->
        Util.mostrar_error("Error recibido del servidor: #{msg}")

      :fin ->
        Util.mostrar_mensaje("Fin.")

      other ->
        IO.puts("Cliente: mensaje desconocido recibido: #{inspect(other)}")
    after
      5_000 ->
        Util.mostrar_error("Tiempo de espera agotado al solicitar la lista de trabajos.")
    end
  end

  defp mostrar_trabajos(trabajos) do
    IO.puts("Lista de trabajos disponibles:")
    trabajos
    |> Enum.with_index()
    |> Enum.each(fn {t, idx} ->
      IO.puts("#{idx} - [#{t.id}] #{t.titulo} (#{t.fecha})")
    end)
  end

  defp seleccionar_trabajo_y_pedir_autores(trabajos) do
    prompt = "Ingrese el índice del trabajo o el título/ID para ver sus autores:"
    seleccion = Util.ingresar(prompt, :texto)

    identificador =
      case Integer.parse(seleccion || "") do
        {num, ""} -> num
        _ -> seleccion
      end

    send(@servicio_remoto, {@servicio_local, {:autores_por_trabajo, identificador}})

    receive do
      {:autores_list, trabajo, autores} ->
        IO.puts("\nTrabajo seleccionado:")
        IO.puts("ID: #{trabajo.id}")
        IO.puts("Título: #{trabajo.titulo}")
        IO.puts("Fecha: #{trabajo.fecha}")
        IO.puts("Descripción: #{trabajo.descripcion}\n")
        IO.puts("Autores asociados:")
        Enum.each(autores, fn a ->
          IO.puts("Cédula: #{a.cedula}")
          IO.puts("Nombre: #{a.nombre} #{a.apellidos}")
          IO.puts("Programa: #{a.programa_academico}")
          IO.puts("Título profesional: #{a.titulo_profesional}")
          IO.puts("-------------------------")
        end)

      {:error, msg} ->
        Util.mostrar_error("Error: #{msg}")

      :fin ->
        Util.mostrar_mensaje("Fin por parte del servidor.")

      other ->
        IO.puts("Cliente: respuesta desconocida: #{inspect(other)}")
    after
      5_000 ->
        Util.mostrar_error("Tiempo de espera agotado al solicitar autores.")
    end
  end
end

NodoCliente.main()
