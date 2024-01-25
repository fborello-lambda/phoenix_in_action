defmodule AuctionWeb.GlobalHelpers do
  def integer_to_currency(amount) do
    dol_cents =
      amount
      |> Decimal.div(100)
      |> Decimal.round(2)

    "$#{dol_cents}"
  end
end
