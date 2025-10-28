defmodule Semaforo do
  # Crea el semáforo con un número de cupos
  def crear(cupos) do
    {:ok, pid} = Agent.start_link(fn -> cupos end)
    pid
  end

  # Intenta entrar al estacionamiento
  # Si no hay cupos, retorna :esperar
  def entrar(pid) do
    Agent.get_and_update(pid, fn
      0 -> {:esperar, 0}
      n -> {:ok, n - 1}
    end)
  end

  # Libera un cupo cuando un carro sale
  def salir(pid) do
    Agent.update(pid, fn n -> n + 1 end)
  end

  # Consulta el número actual de cupos disponibles
  def cupos_disponibles(pid) do
    Agent.get(pid, & &1)
  end
end
