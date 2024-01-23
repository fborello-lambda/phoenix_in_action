defmodule Auction.FakeRepo do
  alias Auction.Item

  @items [
    %Item{
      id: 1,
      title: "item1",
      description: "item1_descr",
      ends_at: ~N[2024-01-22 00:00:00]
    },
    %Item{
      id: 2,
      title: "item2",
      description: "item2_descr",
      ends_at: ~N[2024-01-23 00:00:00]
    },
    %Item{
      id: 3,
      title: "item3",
      description: "item3_descr",
      ends_at: ~N[2024-01-24 00:00:00]
    }
  ]

  def all(Item) do
    @items
  end

  def get!(Item, id) do
    Enum.find(@items, fn item -> item.id === id end)
  end

  def get_by(Item, attr) do
    Enum.find(@items, fn item ->
      Enum.all?(Map.keys(attr), fn key ->
        Map.get(item, key) === attr[key]
      end)
    end)
  end
end
