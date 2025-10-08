defmodule Complejo do
  def transformar(n) when n <= 2 do
    n + 1
  end
  def transformar(n) when rem(n, 2) == 0 do
    transformar(n - 1) + transformar(div(n, 2)) - rem(n, 4)
  end
  def transformar(n) do
    transformar(n - 3) * transformar(rem(n, 5) + 1)
  end
end

IO.puts(Complejo.transformar(7))
