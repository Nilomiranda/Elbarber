defmodule ElbarberWeb.UserController do
  use ElbarberWeb, :controller
  alias ElbarberWeb.UserService

  def index(conn, params) do
    UserService.get_all_users(conn, params)
  end

  def create(conn, params) do
    UserService.create_new_user(conn, params)
  end
end