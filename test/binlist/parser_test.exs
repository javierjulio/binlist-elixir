defmodule Binlist.ParserTest do

  use ExUnit.Case, async: true

  import Binlist.Parser

  defmodule DummyUser do
    defstruct name: nil
  end

  doctest Binlist.Parser

  test "populates struct from given module with response data" do
    response = %{body: "{\"name\": \"Javier Julio\"}", status_code: 200}

    assert {:ok, %DummyUser{name: "Javier Julio"}} == parse(response, DummyUser)
  end

  test "returns 'Bin not found' for 404 status" do
    response = %{body: "", status_code: 404}

    assert {:error, "Bin not found"} == parse(response, nil)
  end

  test "returns 'Request limit reached' for 429 status" do
    response = %{body: "", status_code: 429}

    assert {:error, "Request limit reached"} = parse(response, nil)
  end

  test "returns 'Unknown error' and status for any other error" do
    response = %{body: "", status_code: 500}

    assert {:error, "Unknown error", 500} = parse(response, nil)
  end

end
