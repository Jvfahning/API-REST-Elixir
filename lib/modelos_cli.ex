#João Vitor Alves Fahning
#20220005772
#https://deividfortuna.github.io/fipe/
#https://parallelum.com.br/fipe/api/v1/carros/marcas
#https://parallelum.com.br/fipe/api/v1/carros/marcas/1/modelos
defmodule FipeCLI do
  def start(_type, _args) do
  end

  def run do
    IO.puts("Bem-vindo ao aplicativo dos Modelos de Carros!")
    run_fipe_cli()
  end

  defp run_fipe_cli do
    brands = get_brands()
    case brands do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        brands_json = Jason.decode!(body)
        display_brands(brands_json)
      {:ok, %HTTPoison.Response{status_code: status_code}} ->
        IO.puts("Erro ao obter marcas: #{status_code}")
      {:error, error} ->
        IO.puts("Erro ao fazer solicitação HTTP: #{inspect(error)}")
    end
  end

  defp get_brands do
    FipeAPI.get_brands()
  end

  defp get_models(brand_id) do
    FipeAPI.get_models(brand_id)
  end

  defp display_brands(brands) do
    loop_display_brands(brands)
  end

  defp loop_display_brands(brands) do
    IO.puts("Marcas Disponíveis:")
    Enum.each(brands, fn brand ->
      id = Map.get(brand, "codigo")
      name = Map.get(brand, "nome")
      IO.puts("#{id}: #{name}")
    end)

    IO.puts("Escolha uma marca pelo número ou digite 's' para sair:")
    brand_id = read_user_input()

    case brand_id do
      "s" ->
        IO.puts("Saindo...")
      _ ->
        case get_models(brand_id) do
          {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
            models_json = Jason.decode!(body)
            display_models(models_json, brand_id)
            loop_display_brands(brands) # Mostrar outras marcas
          {:ok, %HTTPoison.Response{status_code: status_code}} ->
            IO.puts("Erro ao obter modelos: #{status_code}")
            loop_display_brands(brands)
          {:error, error} ->
            IO.puts("Erro ao fazer solicitação HTTP: #{inspect(error)}")
            loop_display_brands(brands)
        end
    end
  end

  defp display_models(models, _brand_id) do
    IO.puts("Modelos Disponíveis:")
    Enum.each(models["modelos"], fn model ->
      id = Map.get(model, "codigo")
      name = Map.get(model, "nome")
      IO.puts("#{id}: #{name}")
    end)
  end

  defp read_user_input do
    IO.gets("") |> String.trim()
  end
end
