defmodule BinlistTest do

  use ExUnit.Case

  doctest Binlist

  test "finds a valid bin" do
    {:ok, bin} = Binlist.find(45717360)

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
    assert {:error, "Bin not found"} == Binlist.find(123456)
  end

end
