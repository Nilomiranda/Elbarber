defmodule ElbarberWeb.UserController do
  use ElbarberWeb, :controller
  import Plug.Conn
  import Ecto.Repo
  import Ecto.Query

  alias Elbarber.User
  alias Elbarber.Repo
  alias ElbarberWeb.PayloadValidator

  def index(conn, _params) do
    users = User |> Repo.all
    conn
      |> json(%{:users => users})
  end

  def create(conn, _params) do
    payload = conn.body_params

    missing_fields = PayloadValidator.validate_payload(["name", "email", "password"], payload)

    if length(missing_fields) > 0 do
      conn
        |> put_status(400)
        |> json(%{:error => "MISSING_REQUIRED_FIELD", :message => "Field #{hd(missing_fields)} is required"})
    end

    search_by_email_query = "users"
      |> where([user], user.email == ^payload["email"])
      |> select([user], user.email)

    already_in_use_email = Repo.all(search_by_email_query)

    if already_in_use_email != nil do
      conn |> put_status(409) |> json(%{:error => "EMAIL_IN_USE", :message => "Email #{payload["email"]} is already taken."})
    end

    inserted_user = User.changeset(%User{}, %{name: payload["name"], email: payload["email"], password_hash: payload["password"]})

    case Repo.insert inserted_user do
      {:ok, struct} -> conn |> put_status(200) |> json(struct)
      {:error, changeset} -> conn |> put_status(400) |> json(changeset.errors)
    end

    conn
      |> put_status(201)
      |> json(payload)
  end
end