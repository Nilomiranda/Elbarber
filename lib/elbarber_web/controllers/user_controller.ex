defmodule ElbarberWeb.UserController do
  use ElbarberWeb, :controller

  alias ElbarberWeb.UserService

  import ElbarberWeb.PayloadValidator, except: [action: 2]

  plug :validate_payload, [required_fields: ["name", "email", "password"]] when action in [:create]

  def index(conn, params) do
    users = UserService.get_all_users(conn, params)
    conn
     |> render("index.json", users: users)
  end

  def create(conn, _params) do
    user = UserService.create_new_user(conn)
    conn |> render("show.json", user: user)
  end
end