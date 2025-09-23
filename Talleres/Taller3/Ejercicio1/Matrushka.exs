defmodule Matrushka do
  def abrir_y_cerrar([]) do
    IO.puts("No hay más muñecas dentro.")
  end

  def abrir_y_cerrar([cabeza | resto]) do
    IO.puts("Abriste la muñeca #{cabeza}")
    abrir_y_cerrar(resto)
    IO.puts("Cerraste la muñeca #{cabeza}")
  end
end

Matrushka.abrir_y_cerrar(["Grande", "Mediana", "Pequeña", "Mini"])
