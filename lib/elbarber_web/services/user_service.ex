defmodule ElbarberWeb.UserService do
  use ElbarberWeb, :controller

  import Plug.Conn
  import Ecto.Repo
  import Ecto.Query
  import Argon2

  alias Elbarber.User
  alias Elbarber.Repo


  def get_all_users(conn, _params) do
    users = User |> Repo.all
    conn
    |> json(%{:users => users})
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

    hashed_password = add_hash(payload["password"]).password_hash

    inserted_user = User.changeset(%User{}, Map.put(payload, "password_hash", hashed_password))

    case Repo.insert inserted_user do
      {:ok, struct} -> conn |> put_status(200) |> json(struct)
      {:error, changeset} -> conn |> put_status(400) |> json(changeset.errors)
    end

    conn
    |> put_status(201)
    |> json(payload)
  end
end