# Binlist

[![Hex.pm](https://img.shields.io/hexpm/v/binlist.svg)](https://hex.pm/packages/binlist)

Binlist is an Elixir client library for [the Binlist.net service](https://binlist.net).

## Installation

First, add Binlist to your `mix.exs` dependencies:

```elixir
def deps do
  [ {:binlist, "~> 0.1.0"} ]
end
```

Then, update your dependencies:

```
$ mix deps.get
```

## Usage

Make a request, specifying the bin number as an integer or string:

```elixir
{:ok, bin} = Binlist.find(45717360)
```

And if successful, `bin` is a `%Binlist.Bin{}` struct:

```elixir
bin.scheme  # "visa"
bin.type    # "debit"
bin.prepaid # false
```

If an error occurs either of the following are returned:

```elixir
# For a 404:
{:error, "Bin not found"}

# For a 429:
{:error, "Request limit reached"}

# For any other 4xx or 5xx status:
{:error, "Unknown error", status}
```

## Contributing

This is my first Elixir library so if you notice something wrong, please open an issue or better yet submit a pull request.

Make a change and then run tests `mix test` to verify your changes. Note that the tests are integration based.

Binlist.net sometimes doesn't return a field for one bin but it does for another. Since the library uses structs, if you notice any fields missing please submit an issue along with the bin introducing the field.

## Misc

As this was my first Elixir library, I looked to other projects to see how they were configured so I knew how to distribute on Hex. I liked the code I read in [ex_twilio](https://github.com/danielberkompas/ex_twilio) so I used the same approach to parsing a response.
