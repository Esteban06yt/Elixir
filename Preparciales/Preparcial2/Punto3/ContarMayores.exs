defmodule ContarMayores do
  def contar([], _num), do: 0

  def contar([cabeza | cola], num) do
    if cabeza > num do
      1 + contar(cola, num)
    else
      contar(cola, num)
    end
  end
end

lista = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
num = 6

IO.puts("Cantidad de elementos mayores que #{num}: #{ContarMayores.contar(lista, num)}")
