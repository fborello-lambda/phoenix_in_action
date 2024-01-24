defmodule Auction do
  alias Auction.Item

  @repo Auction.Repo

  def new_item do
    Item.changeset(%Item{})
  end

  def list_items do
    @repo.all(Item)
  end

  def get_item(id) do
    @repo.get!(Item, id)
  end

  def get_item_by(attrs) do
    @repo.get_by(Item, attrs)
  end

  def insert_item(attrs) do
    %Item{} |> Item.changeset(attrs) |> @repo.insert()
  end

  def delete_item(%Auction.Item{} = item) do
    @repo.delete(item)
  end

  def update_item(%Auction.Item{} = item, updates) do
    item
    |> Item.changeset(updates)
    |> @repo.update()
  end

  def edit_item(id) do
    get_item(id)
    |> Item.changeset()
  end

  def displ() do
    list =
      for item <- list_items() do
        "#{item.id} - #{item.title} - #{item.description} - #{item.ends_at}"
      end

    list |> Enum.join("\n")
  end

  def insert_all() do
    for item <- Auction.Item.items() do
      insert_item(item)
    end
  end
end
