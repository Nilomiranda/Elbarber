defmodule ElbarberWeb.UserService do
  use ElbarberWeb, :controller

  import Plug.Conn
  import Ecto.Repo
  import Ecto.Query
  import ElbarberWeb.ResponseHelpers

  alias Elbarber.User
  alias Elbarber.Repo


  def get_all_users(conn, _params) do
    users = User |> Repo.all
  end

  def create_new_user(conn)  do
    payload = conn.body_params

    search_by_email_query = "users"
      |> where([user], user.email == ^payload["email"])
      |> select([user], user.email)

    already_in_use_email = Repo.one(search_by_email_query)

    if !is_nil(already_in_use_email) do
      conn |> put_status(409) |> json(%{:error => "EMAIL_IN_USE", :message => "Email #{payload["email"]} is already taken."})
    end

    user_to_insert = User.changeset(%User{}, payload)

    case Repo.insert user_to_insert do
      {:ok, new_user} -> {:ok, new_user}
      {:error, changeset} -> {:error, changeset}
    end
  end
end