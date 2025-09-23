defmodule Evaluacion do
  def evaluar_proyecto(calificaciones, estudiante) do
    case Map.fetch(calificaciones, estudiante) do
      :error -> {0, "No encontrado"}
      {:ok, notas} ->
        promedio = Enum.sum(notas) / length(notas)
        estado = if promedio >= 6, do: "Aprobado", else: "Reprobado"
        {promedio, estado}
    end
  end

  def main do
    calificaciones = %{
      "Ana" => [7, 8, 6],
      "Luis" => [5, 4, 6],
      "Marta" => [9, 9, 10]
    }
    IO.inspect(evaluar_proyecto(calificaciones, "Ana"))
    IO.inspect(evaluar_proyecto(calificaciones, "Luis"))
    IO.inspect(evaluar_proyecto(calificaciones, "Marta"))
    IO.inspect(evaluar_proyecto(calificaciones, "Pedro"))
  end
end

Evaluacion.main()
