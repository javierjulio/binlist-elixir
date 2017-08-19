defmodule Binlist.Bin do

  defstruct number: %Binlist.Number{},
    scheme: nil,
    type: nil,
    brand: nil,
    prepaid: nil,
    country: %Binlist.Country{},
    bank: %Binlist.Bank{}

end
