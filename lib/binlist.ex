defmodule Binlist do
  @moduledoc """
  A client library for the Binlist.net service.
  """

  use HTTPoison.Base

  alias Binlist.{Bin, Parser}

  @doc """
  Returns a Binlist.Bin struct for the requested bin number.

  ## Examples

      iex> Binlist.find(45717360)
      {:ok,
      %Binlist.Bin{bank: %Binlist.Bank{city: "Hjørring", name: "Jyske Bank",
        phone: "+4589893300", url: "www.jyskebank.dk"}, brand: "Visa/Dankort",
        country: %Binlist.Country{alpha2: "DK", currency: "DKK", emoji: "🇩🇰",
        latitude: 56, longitude: 10, name: "Denmark", numeric: "208"},
        number: %Binlist.Number{length: 16, luhn: true}, prepaid: false,
        scheme: "visa", type: "debit"}}

      iex> Binlist.find(123456)
      {:error, "Bin not found"}

  """
  def find(bin) do
    "https://lookup.binlist.net/#{bin}"
    |> Binlist.get!("Accept-Version": "3")
    |> Parser.parse(Bin)
  end
end
