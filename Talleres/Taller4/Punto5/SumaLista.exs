defmodule SumaLista do
  def suma([]), do: 0
  def suma([h | t]), do: h + suma(t)

  def main do
    IO.inspect(suma([1,2,3,4,5]))
  end
end

SumaLista.main()
