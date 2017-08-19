defmodule Binlist.Parser do

  @type success          :: {:ok, [map]}
  @type error            :: {:error, String.t}

  @spec parse(HTTPoison.Response.t, module) :: success | error
  def parse(response, module) do
    handle_errors response, fn(body) ->
      Poison.decode!(body, as: target(module))
    end
  end

  defp target(module) when is_atom(module), do: module.__struct__
  defp target(other), do: other

  defp handle_errors(response, fun) do
    case response do
      %{body: body, status_code: status} when status in [200, 201] ->
        {:ok, fun.(body)}

      %{body: _, status_code: 404} ->
        {:error, "Bin not found"}

      %{body: _, status_code: 429} ->
        {:error, "Request limit reached"}

      %{body: _, status_code: status} ->
        {:error, "Unknown error", status}
    end
  end

end
