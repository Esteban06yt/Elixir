defmodule Estacionamiento do
  def main do
    "Simulación de estacionamiento con cupos limitados"
    |> Util.mostrar_mensaje()

    cupos =
      "Ingrese el número de espacios disponibles: "
      |> Util.ingresar(:entero)

    semaforo = Semaforo.crear(cupos)

    carros =
      ["Carro 1", "Carro 2", "Carro 3", "Carro 4", "Carro 5"]
      |> Enum.map(&Carro.crear/1)

    Enum.each(carros, fn carro ->
      Task.start(fn -> Carro.intentar_entrar(carro, semaforo) end)
    end)

    esperar_terminar()
  end

  defp esperar_terminar do
    Process.sleep(7000)
    "\nSimulación terminada.\n"
    |> Util.mostrar_mensaje()
  end
end

Estacionamiento.main()
