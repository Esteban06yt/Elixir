defmodule DivideVenceras do
  def suma([]), do: 0
  def suma([x]), do: x

  def suma(lista) do
    mitad = div(length(lista), 2)
    {izquierda, derecha} = Enum.split(lista, mitad)

    suma(izquierda) + suma(derecha)
  end
end

IO.puts(DivideVenceras.suma([1, 2, 3, 4, 5, 6]))
