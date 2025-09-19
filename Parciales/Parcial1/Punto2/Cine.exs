defmodule Cine do
  def salas do
    %{
      1 => 50,
      2 => 30,
      3 => 20
    }
  end

  def reservar_sillas(salas, sala_num, cantidad) do
    case Map.fetch(salas, sala_num) do
      :error ->
        IO.puts("Sala no encontrada")
        salas

      {:ok, disponibles} when cantidad > disponibles ->
        IO.puts("No hay suficientes sillas disponibles")
        salas

      {:ok, disponibles} ->
        actualizado = Map.put(salas, sala_num, disponibles - cantidad)
        IO.puts("Reserva realizada con éxito en la sala #{sala_num}")
        actualizado
    end
  end
end

salas = Cine.salas()
IO.inspect(salas)

salas = Cine.reservar_sillas(salas, 2, 10)
IO.inspect(salas)

salas = Cine.reservar_sillas(salas, 3, 25)
IO.inspect(salas)

salas = Cine.reservar_sillas(salas, 5, 5)
IO.inspect(salas)
