defmodule SumaPares do
  def suma([]), do: 0
  def suma([h | t]) when rem(h,2)==0, do: h + suma(t)
  def suma([_ | t]), do: suma(t)

  def main do
    IO.inspect(suma([1,2,3,4,5,6]))
  end
end

SumaPares.main()
