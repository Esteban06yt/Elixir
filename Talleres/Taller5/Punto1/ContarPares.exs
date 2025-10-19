defmodule ContarPares do
  def contar([]), do: 0

  def contar([cabeza | cola]) do
    if rem(cabeza, 2) == 0 do
      1 + contar(cola)
    else
      contar(cola)
    end
  end
end

IO.puts(ContarPares.contar([1, 2, 3, 4, 6, 7]))
