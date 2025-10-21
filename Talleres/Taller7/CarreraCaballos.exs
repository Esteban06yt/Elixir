defmodule CarreraCaballos do
  def caballo(nombre, meta, padre) do
    avanzar(nombre, 0, meta, padre)
  end

  defp avanzar(nombre, posicion, meta, padre) when posicion < meta do
    :timer.sleep(:rand.uniform(600) + 200)
    nueva_pos = posicion + :rand.uniform(3)
    IO.puts("#{nombre} avanza a posición #{min(nueva_pos, meta)}")

    avanzar(nombre, nueva_pos, meta, padre)
  end

  defp avanzar(nombre, posicion, meta, padre) when posicion >= meta do
    send(padre, {:termino, nombre})
  end

  def main do
    caballos = ["Agnes Tachyon", "Gold Ship", "Haru Urara", "Special Week"]
    meta = 20
    IO.puts("\n¡Comienza la carrera de caballos!\n")
    Enum.each(caballos, fn nombre ->
      spawn(CarreraCaballos, :caballo, [nombre, meta, self()])
    end)
    ganador = esperar_ganador(length(caballos))
    IO.puts("\nEl ganador es: #{ganador}")
  end

  defp esperar_ganador(0), do: "Nadie"
  defp esperar_ganador(_) do
    receive do
      {:termino, nombre} ->
        nombre
    end
  end
end

CarreraCaballos.main()
