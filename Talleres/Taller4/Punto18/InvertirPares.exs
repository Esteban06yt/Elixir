defmodule InvertirPares do
  def invertir([]), do: []
  def invertir([a, b | t]), do: [b, a | invertir(t)]
  def invertir([a]), do: [a]

  def main do
    IO.inspect(invertir([1,2,3,4,5]))
  end
end

InvertirPares.main()
