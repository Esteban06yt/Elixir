defmodule Inventario do
  def inventario_inicial do
    %{"Laptop" => 10, "Mouse" => 20, "Teclado" => 15}
  end

  def actualizar_inventario(inventario, producto, cantidad) do
    case Map.fetch(inventario, producto) do
      :error ->
        IO.puts("Producto no encontrado")
        inventario
      {:ok, stock} when cantidad > stock ->
        IO.puts("Stock insuficiente")
        inventario
      {:ok, stock} ->
        Map.put(inventario, producto, stock - cantidad)
    end
  end

  def main do
    inv = inventario_inicial()
    IO.inspect(inv)
    inv = actualizar_inventario(inv, "Laptop", 3)
    IO.inspect(inv)
    actualizar_inventario(inv, "Tablet", 2)
    actualizar_inventario(inv, "Mouse", 25)
  end
end

Inventario.main()
