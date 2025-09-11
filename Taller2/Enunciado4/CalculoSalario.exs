defmodule CalculoSalario do
  def main do
    nombre =
      "Ingrese el nombre del empleado: "
      |> Util.ingresar(:texto)

    salario_base =
      "Ingrese el salario base: "
      |> Util.ingresar(:real)

    horas_extras =
      "Ingrese las horas extras trabajadas: "
      |> Util.ingresar(:entero)

    salario_total = calcular_salario_total(salario_base, horas_extras)

    generar_mensaje(nombre, salario_total)
    |> Util.mostrar_mensaje()
  end

  defp calcular_salario_total(salario_base, horas_extras) do
    # Valor de la hora normal: salario_base / 160 (8 horas diarias * 20 dias al mes)
    valor_hora = salario_base / 160
    pago_extras = horas_extras * valor_hora * 1.5
    salario_base + pago_extras
  end

  def generar_mensaje(nombre, salario_total) do
    salario_total = Float.round(salario_total, 2)
    "El salario total de #{nombre} es de $#{salario_total}."
  end
end

CalculoSalario.main()
