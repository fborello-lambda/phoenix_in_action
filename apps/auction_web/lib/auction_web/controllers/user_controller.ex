defmodule AuctionWeb.UserController do
  use AuctionWeb, :live_view
  use AuctionWeb, :controller
  plug :prevent_unauthorized_access when action in [:show]

  def show(conn, %{"id" => id}) do
    user = Auction.get_user(id)
    bids = Auction.get_bids_for_user(user)
    render(conn, :show, user: user, bids: bids)
  end

  def new(conn, _params) do
    user = Auction.new_user()
    render(conn, :new, form: to_form(user))
  end

  def create(conn, %{"user" => user_params}) do
    case Auction.insert_user(user_params) do
      {:ok, item} ->
        Phoenix.Controller.redirect(conn, to: ~p"/users/#{item.id}")

      {:error, _item} ->
        conn
        |> Phoenix.Controller.put_flash(:error, "Try again")
        |> Phoenix.Controller.redirect(to: ~p"/users/new")
    end
  end

  defp prevent_unauthorized_access(conn, _opts) do
    current_user = Map.get(conn.assigns, :current_user)

    requested_user_id =
      conn.params
      |> Map.get("id")
      |> String.to_integer()

    if current_user == nil || current_user.id != requested_user_id do
      conn
      |> Phoenix.Controller.put_flash(:error, "Not allowed")
      |> Phoenix.Controller.redirect(to: "/login")
      |> halt()
    else
      conn
    end
  end
end
