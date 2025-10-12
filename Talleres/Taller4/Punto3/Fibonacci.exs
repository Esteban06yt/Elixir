defmodule Fibonacci do
  def fib(0), do: 0
  def fib(1), do: 1
  def fib(n), do: fib(n - 1) + fib(n - 2)

  def main do
    IO.inspect(fib(6))
  end
end

Fibonacci.main()
