defmodule SalarioNeto do
  def main do
    nombre =
      "Digite el nombre del empleado: "
      |> Util.ingresar(:texto)

    horas =
      "Digite las horas trabajadas: "
      |> Util.ingresar(:entero)

    valor_hora =
      "Digite el valor por hora: "
      |> Util.ingresar(:real)

    salario_neto = calcular_salario(horas, valor_hora)

    generar_mensaje(nombre, salario_neto)
    |> Util.mostrar_mensaje()
  end

  defp calcular_salario(horas, valor_hora) do
    base_horas = min(horas, 160)
    horas_extra = max(horas - 160, 0)

    salario_base = base_horas * valor_hora
    salario_extra = horas_extra * valor_hora * 1.25

    salario_base + salario_extra
  end

  def generar_mensaje(nombre, salario_neto) do
    salario_neto = Float.round(salario_neto, 2)
    "El salario neto de #{nombre} es: $#{salario_neto}"
  end
end

SalarioNeto.main()
