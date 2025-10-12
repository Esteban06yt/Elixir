defmodule ConcatenarListas do
  def concat([], l2), do: l2
  def concat([h | t], l2), do: [h | concat(t, l2)]

  def main do
    IO.inspect(concat([1,2],[3,4]))
  end
end

ConcatenarListas.main()
