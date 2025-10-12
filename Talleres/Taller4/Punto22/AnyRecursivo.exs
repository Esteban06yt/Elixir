defmodule AnyRecursivo do
  def any?([], _f), do: false
  def any?([h | t], f) do
    if f.(h), do: true, else: any?(t, f)
  end

  def main do
    IO.inspect(any?([1,2,3], fn x -> x > 2 end))
  end
end

AnyRecursivo.main()
