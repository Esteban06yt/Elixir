defmodule Tienda do
  def main do
    tienda = [
      %{nombre: "Espada", precio: 50, stock: 2},
      %{nombre: "Escudo", precio: 30, stock: 1},
      %{nombre: "Poción", precio: 10, stock: 5}
    ]

    jugador = %{nombre: "Aventurero", oro: 100, inventario: []}

    loop_compras(tienda, jugador)
  end

  defp loop_compras(tienda, jugador) do
    Util.mostrar_mensaje("Oro obtenido: #{jugador.oro}")
    Util.mostrar_mensaje("\n=== Catálogo de la tienda ===")
    Enum.each(tienda, fn prod ->
      Util.mostrar_mensaje("#{prod.nombre} - Precio: #{prod.precio}, Stock: #{prod.stock}")
    end)

    producto_buscado = Util.ingresar("\n¿Qué deseas comprar? (o escribe 'salir')", :texto)

    if String.downcase(producto_buscado) == "salir" do
      Util.mostrar_mensaje("\nJuego terminado.")
      Util.mostrar_mensaje("Inventario final: #{inspect(jugador.inventario)}")
      Util.mostrar_mensaje("Oro restante: #{jugador.oro}")
    else
      cantidad = Util.ingresar("¿Cuántos deseas comprar?", :entero)

      producto = Enum.find(tienda, fn p -> String.downcase(p.nombre) == String.downcase(producto_buscado) end)

      cond do
        producto == nil ->
          Util.mostrar_mensaje("Ese producto no existe.")
          loop_compras(tienda, jugador)

        cantidad <= 0 ->
          Util.mostrar_mensaje("Cantidad inválida.")
          loop_compras(tienda, jugador)

        producto.stock < cantidad ->
          Util.mostrar_mensaje("No hay suficiente stock disponible.")
          loop_compras(tienda, jugador)

        jugador.oro < producto.precio * cantidad ->
          Util.mostrar_mensaje("No tienes suficiente oro.")
          loop_compras(tienda, jugador)

        true ->
          # Actualizar jugador
          jugador = %{
            jugador
            | oro: jugador.oro - producto.precio * cantidad,
              inventario: jugador.inventario ++ List.duplicate(producto.nombre, cantidad)
          }

          # Actualizar tienda
          tienda_actualizada =
            Enum.map(tienda, fn p ->
              if p.nombre == producto.nombre do
                %{p | stock: p.stock - cantidad}
              else
                p
              end
            end)

          Util.mostrar_mensaje("\n¡Compra realizada!")
          Util.mostrar_mensaje("Oro restante: #{jugador.oro}")
          Util.mostrar_mensaje("Inventario: #{inspect(jugador.inventario)}")

          loop_compras(tienda_actualizada, jugador)
      end
    end
  end
end

Tienda.main()
