defmodule AuctionWeb.Api.ItemJSON do
  alias Auction.Item

  def index(%{items: items}) do
    %{data: for(item <- items, do: data(item))}
  end

  defp data(%Item{} = item) do
    %{
      id: item.id,
      title: item.title,
      descr: item.description,
      ends_at: item.ends_at
    }
  end
end
