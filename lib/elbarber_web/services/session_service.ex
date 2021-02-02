defmodule ElbarberWeb.SessionService do
  use ElbarberWeb, :controller

  import Plug.Conn
  import Ecto.Repo
  import Ecto.Query
  import ElbarberWeb.ResponseHelpers

  alias Elbarber.User
  alias Elbarber.Repo

  def authenticate_user(conn) do
    payload = conn.body_params

    user_query = "users"
    |> where([user], user.email == ^payload["email"])
    |> select([user], [user.email, user.password_hash])

    user = Repo.get_by(User, [email: payload["email"]])

    IO.puts "FOUND USER"
    IO.inspect user

    conn
    |> put_status(201)
    |> json(user)
  end

end