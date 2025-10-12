defmodule SumaN do
  def suma(0), do: 0
  def suma(n), do: n + suma(n - 1)

  def main do
    IO.inspect(suma(5))
  end
end

SumaN.main()
