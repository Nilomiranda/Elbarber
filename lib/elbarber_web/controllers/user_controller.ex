defmodule ElbarberWeb.UserController do
  use ElbarberWeb, :controller
  import Plug.Conn
  import Ecto.Repo

  def index(conn, _params) do
    users = Elbarber.User |> Elbarber.Repo.all
    conn
      |> put_status(400)
      |> json(%{:users => users})
  end
end