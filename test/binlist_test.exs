defmodule BinlistTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  doctest Binlist

  setup_all do
    {:ok, _} = HTTPoison.start()
    :ok
  end

  test "finds a valid bin" do
    {:ok, bin} =
      use_cassette "get_bin_visa_debit" do
        Binlist.find(45_717_360)
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

  test "finds a bin for a different scheme and type" do
    {:ok, bin} =
      use_cassette "get_bin_mastercard_credit" do
        Binlist.find(513_101)
      end

    assert bin.scheme == "mastercard"
    assert bin.type == "credit"
    refute bin.prepaid
    refute bin.brand
    refute bin.bank.city
    assert bin.bank.name == "CREDIT AGRICOLE"
    assert bin.bank.phone == "0156581212"
    refute bin.bank.url
    assert bin.country.alpha2 == "FR"
    assert bin.country.currency == "EUR"
    assert bin.country.emoji == "🇫🇷"
    assert bin.country.latitude == 46
    assert bin.country.longitude == 2
    assert bin.country.name == "France"
    assert bin.country.numeric == "250"
    refute bin.number.length
    refute bin.number.luhn
  end

  test "finds a valid bin as a string" do
    {:ok, bin} =
      use_cassette "get_bin_visa_debit" do
        Binlist.find("45717360")
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
    use_cassette "get_bin_not_found_error" do
      assert {:error, "Bin not found"} == Binlist.find(123_456)
    end
  end
end
