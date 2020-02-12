defmodule BinlistTest do

  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  doctest Binlist

  setup_all do
    {:ok, _} = HTTPoison.start
    :ok
  end

  test "finds a valid bin" do
    {:ok, bin} = use_cassette "bin_found" do
      Binlist.find(45717360)
    end

    assert bin.scheme == "visa"
    assert bin.type == "debit"
    refute bin.prepaid
    assert bin.brand == "Visa/Dankort"
    assert bin.bank.city == "Hjørring"
    assert bin.bank.name == "Jyske Bank"
    assert bin.bank.phone == "+4589893300"
    assert bin.bank.url == "www.jyskebank.dk"
    assert bin.country.alpha2 == "DK"
    assert bin.country.currency == "DKK"
    assert bin.country.emoji == "🇩🇰"
    assert bin.country.latitude == 56
    assert bin.country.longitude == 10
    assert bin.country.name == "Denmark"
    assert bin.country.numeric == "208"
    assert bin.number.length == 16
    assert bin.number.luhn
  end

  test "returns an error if bin not found" do
    use_cassette "bin_not_found" do
      assert {:error, "Bin not found"} == Binlist.find(123456)
    end
  end
end
