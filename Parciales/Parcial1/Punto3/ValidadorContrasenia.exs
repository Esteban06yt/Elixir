defmodule ValidadorContrasenia do
  def main do
    contrasenia =
      "Ingrese la contraseña a validar: "
      |> Util.ingresar(:texto)

    validar(contrasenia)
    |> mostrar_resultado()
  end

  def validar(contrasenia) do
    []
    |> validar_longitud(contrasenia)
    |> validar_mayuscula(contrasenia)
    |> validar_numero(contrasenia)
    |> validar_espacios(contrasenia)
    |> resultado()
  end

  defp validar_longitud(errores, contrasenia) do
    if String.length(contrasenia) >= 8 do
      errores
    else
      errores ++ ["Debe tener al menos 8 caracteres"]
    end
  end

  defp validar_mayuscula(errores, contrasenia) do
    if contrasenia != String.downcase(contrasenia) do
      errores
    else
      errores ++ ["Debe contener al menos una letra mayúscula"]
    end
  end

  defp validar_numero(errores, contrasenia) do
    if String.replace(contrasenia, ~r/[0-9]/, "") != contrasenia do
      errores
    else
      errores ++ ["Debe contener al menos un número"]
    end
  end

  defp validar_espacios(errores, contrasenia) do
    if String.contains?(contrasenia, " ") do
      errores ++ ["No debe contener espacios"]
    else
      errores
    end
  end

  defp resultado([]), do: {:ok, "Contraseña segura"}
  defp resultado(errores), do: {:error, Enum.join(errores, " | ")}

  def mostrar_resultado({:ok, msg}) do
    Util.mostrar_mensaje(msg)
  end

  def mostrar_resultado({:error, msg}) do
    Util.mostrar_mensaje("Errores encontrados: #{msg}")
  end
end

ValidadorContrasenia.main()
