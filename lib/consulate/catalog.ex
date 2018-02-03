defmodule Consulate.Catalog do
  alias Consulate.Consul.Api

  @catalog "catalog"
  @services "services"
  @service "service"
  @datacenters "datacenters"
  @node "node"
  @nodes "nodes"

  def register, do: nil
  def deregister, do: nil

  def datacenters do
    Api.make_request([@catalog, @datacenters], :get)
  end

  def nodes(options \\ []) do
    params = prepare_params(options, ~w(dc near node-meta)a)
    path = [@catalog, @nodes]
    Api.make_request(path, :get, params)
  end

  def services(options \\ []) do
    params = prepare_params(options, ~w(dc node-meta)a)
    path = [@catalog, @services]
    Api.make_request(path, :get, params)
  end

  def service(service_name, options \\ []) do
    params = prepare_params(options, ~w(dc tag near node-meta)a)
    path = [@catalog, @service, service_name]
    Api.make_request(path, :get, params)
  end

  def node_service(node) do
    path = [@catalog, @node, node]
    Api.make_request(path, :get)
  end

  defp prepare_params(params, _) when length(params) == 0, do: []

  defp prepare_params(params, allowed_params) do
    Keyword.take(params, allowed_params)
  end
end
