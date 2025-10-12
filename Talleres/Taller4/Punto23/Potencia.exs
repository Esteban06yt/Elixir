defmodule Potencia do
  def potencia(_, 0), do: 1
  def potencia(base, exp), do: base * potencia(base, exp-1)

  def main do
    IO.inspect(potencia(2,3))
  end
end

Potencia.main()
