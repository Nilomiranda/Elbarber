defmodule ElbarberWeb.UserController do
  use ElbarberWeb, :controller
  import Plug.Conn
  import Ecto.Repo

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
        |> json(%{:error => "MISSING_REQUIRED_FIELD", :detail => "Field #{hd(missing_fields)} is required"})
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