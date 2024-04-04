#João Vitor Alves Fahning
#20220005772
#https://deividfortuna.github.io/fipe/
#https://parallelum.com.br/fipe/api/v1/carros/marcas
#https://parallelum.com.br/fipe/api/v1/carros/marcas/1/modelos
defmodule FipeAPI do
  @base_url "https://parallelum.com.br/fipe/api/v1/carros"

  def get_brands do
    url = "#{@base_url}/marcas"
    HTTPoison.get(url)
  end

  def get_models(brand_id) do
    url = "#{@base_url}/marcas/#{brand_id}/modelos"
    HTTPoison.get(url)
  end
end
