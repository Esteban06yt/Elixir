defmodule SumaDigitos do
  def suma(0), do: 0
  def suma(n), do: rem(n,10) + suma(div(n,10))

  def main do
    IO.inspect(suma(1234))
  end
end

SumaDigitos.main()
