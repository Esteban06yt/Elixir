defmodule Factorial do
  def factorial(0), do: 1
  def factorial(n), do: n * factorial(n - 1)

  def main do
    IO.inspect(factorial(5))
  end
end

Factorial.main()
