defmodule Ordenada do
  def asc?([]), do: true
  def asc?([_]), do: true
  def asc?([a,b | t]) when a <= b, do: asc?([b | t])
  def asc?(_), do: false

  def main do
    IO.inspect(asc?([1,2,3,4]))
    IO.inspect(asc?([3,2,1]))
  end
end

Ordenada.main()
