defmodule Auction.Item do
  use Ecto.Schema

  @items [
    %{
      id: 1,
      title: "item1",
      description: "item1_descr",
      ends_at: DateTime.from_naive!(~N[2024-01-24 00:00:00], "Etc/UTC")
    },
    %{
      id: 2,
      title: "item2",
      description: "item2_descr",
      ends_at: DateTime.from_naive!(~N[2024-01-25 00:00:00], "Etc/UTC")
    },
    %{
      id: 3,
      title: "item3",
      description: "item3_descr",
      ends_at: DateTime.from_naive!(~N[2024-01-26 00:00:00], "Etc/UTC")
    }
  ]

  def items() do
    @items
  end

  schema "items" do
    field(:title, :string)
    field(:description, :string)
    field(:ends_at, :utc_datetime)
    timestamps()
  end
end
