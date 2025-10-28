defmodule Carro do
  defstruct nombre: ""

  def crear(nombre), do: %Carro{nombre: nombre}

  # Cada carro intenta entrar al estacionamiento
  def intentar_entrar(carro, semaforo) do
    case Semaforo.entrar(semaforo) do
      :esperar ->
        mensaje = "#{carro.nombre} espera: no hay cupos disponibles."
        mostrar_mensaje(mensaje)
        Process.sleep(1000)
        intentar_entrar(carro, semaforo)

      :ok ->
        # Esperamos un instante para permitir que el Agent se actualice
        Process.sleep(50)
        disponibles = Semaforo.cupos_disponibles(semaforo)
        mensaje = "#{carro.nombre} entró al estacionamiento. Cupos restantes: #{disponibles}"
        mostrar_mensaje(mensaje)
        estacionar(carro, semaforo)
    end
  end

  # Simula el tiempo de permanencia del carro dentro del estacionamiento
  defp estacionar(carro, semaforo) do
    tiempo = Enum.random(2000..4000)
    Process.sleep(tiempo)

    Semaforo.salir(semaforo)
    Process.sleep(50)
    disponibles = Semaforo.cupos_disponibles(semaforo)

    mensaje = "#{carro.nombre} sale del estacionamiento. Cupos disponibles: #{disponibles}"
    mostrar_mensaje(mensaje)
  end

  # Muestra mensaje en consola
  defp mostrar_mensaje(mensaje) do
    IO.puts(mensaje)
  end
end
