defmodule Auction do
  alias Auction.{FakeRepo, Item}

  @repo FakeRepo

  def list_items do
    @repo.all(Item)
  end

  def get_item(id) do
    @repo.get!(Item, id)
  end

  def get_item_by(attrs) do
    @repo.get_by(Item, attrs)
  end

  def displ() do
    list =
      for item <- list_items() do
        "#{item.id} - #{item.title} - #{item.description} - #{item.ends_at}"
      end

    list |> Enum.join("\n")
  end
end
