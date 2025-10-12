defmodule MaximoDivideVenceras do
  def maximo([x]), do: x
  def maximo(lista) do
    mitad = div(length(lista), 2)
    {izq, der} = Enum.split(lista, mitad)
    max_izq = maximo(izq)
    max_der = maximo(der)
    if max_izq > max_der, do: max_izq, else: max_der
  end

  def main do
    lista = [3, 9, 2, 7, 5]
    IO.inspect(maximo(lista))
  end
end

MaximoDivideVenceras.main()
