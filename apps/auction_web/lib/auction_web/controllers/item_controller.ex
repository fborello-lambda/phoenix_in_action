defmodule AuctionWeb.ItemController do
  use AuctionWeb, :live_view
  use AuctionWeb, :controller

  def index(conn, _params) do
    render(conn, :test)
  end

  def show(conn, %{"id" => id}) do
    item = Auction.get_item_with_bids(id)
    bid = Auction.new_bid()
    render(conn, :show, item: item, form: to_form(bid))
  end

  def new(conn, _params) do
    item = Auction.new_item()
    render(conn, :new, form: to_form(item))
  end

  def create(conn, %{"item" => item_params}) do
    case Auction.insert_item(item_params) do
      {:ok, item} ->
        Phoenix.Controller.redirect(conn, to: ~p"/items/#{item.id}")

      {:error, _item} ->
        conn
        |> Phoenix.Controller.put_flash(:error, "Try again")
        |> Phoenix.Controller.redirect(to: ~p"/items/new")
    end
  end

  def edit(conn, %{"id" => id}) do
    item = Auction.edit_item(id)
    render(conn, :edit, form: to_form(item), id: id)
  end

  def update(conn, %{"id" => id, "item" => item_params}) do
    item = Auction.get_item(id)

    case Auction.update_item(item, item_params) do
      {:ok, item} ->
        Phoenix.Controller.redirect(conn, to: ~p"/items/#{item.id}")

      {:error, item} ->
        conn
        |> Phoenix.Controller.put_flash(:error, "Try again")
        |> Phoenix.Controller.redirect(to: ~p"/items/edit/#{item.id}")
    end
  end
end
