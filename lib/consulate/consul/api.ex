defmodule Consulate.Consul.Api do
  use HTTPoison.Base

  def process_url(url) do
    Application.fetch_env!(:consulate, :consul_url) <> "/v1/" <> url
  end

  def process_response_body(body) do
    body
    |> Poison.decode!()
  end

  def make_request(path, method, params \\ []) do
    apply(__MODULE__, method, [Path.join(path), [], params])
    |> process_response()
  end

  defp process_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    body
  end
end
