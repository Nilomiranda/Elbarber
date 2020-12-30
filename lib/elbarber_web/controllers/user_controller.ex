defmodule ElbarberWeb.UserController do
  use ElbarberWeb, :controller

  alias ElbarberWeb.UserService

  import ElbarberWeb.PayloadValidator, except: [action: 2]

  plug :validate_payload, [required_fields: ["name", "email", "password"]] when action in [:create]

  def index(conn, params) do
    UserService.get_all_users(conn, params)
  end

  def create(conn, _params) do
    UserService.create_new_user(conn)
  end
end