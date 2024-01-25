defmodule AuctionWeb.SessionController do
  use AuctionWeb, :live_view
  use AuctionWeb, :controller

  def show(conn, %{"id" => id}) do
    user = Auction.get_user(id)
    render(conn, :show, user: user)
  end

  def new(conn, _params) do
    user = Auction.new_user()
    render(conn, :new, form: to_form(user))
  end

  def create(conn, %{"user" => %{"username" => username, "password" => password}}) do
    case Auction.get_user_by_username_and_password(username, password) do
      %Auction.User{} = user ->
        conn
        |> put_session(:user_id, user.id)
        |> Phoenix.Controller.put_flash(:info, "You () Logged In")
        |> Phoenix.Controller.redirect(to: ~p"/users/#{user.id}")

      _ ->
        conn
        |> Phoenix.Controller.put_flash(:error, "Try again")
        |> Phoenix.Controller.redirect(to: ~p"/login")
    end
  end

  def delete(conn, _params) do
    conn
    |> clear_session()
    |> configure_session(drop: true)
    |> Phoenix.Controller.redirect(to: ~p"/")
  end
end
