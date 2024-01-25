defmodule AuctionWeb.BidController do
  use AuctionWeb, :controller
  use AuctionWeb, :live_view
  plug :require_logged_in_user

  def create(conn, %{"bid" => %{"amount" => amount}, "item_id" => item_id}) do
    user_id = conn.assigns.current_user.id

    case Auction.insert_bid(%{amount: amount, item_id: item_id, user_id: user_id}) do
      {:ok, bid} ->
        Phoenix.Controller.redirect(conn, to: ~p"/items/#{bid.item_id}")

      {:error, _bid} ->
        conn
        |> Phoenix.Controller.put_flash(:error, "Try again")
    end
  end

  defp require_logged_in_user(%{assigns: %{current_user: nil}} = conn, _opts) do
    conn
    |> Phoenix.Controller.put_flash(:error, "Log in required")
    |> Phoenix.Controller.redirect(to: ~p"/login")
    |> halt()
  end

  defp require_logged_in_user(conn, _opts), do: conn
end
