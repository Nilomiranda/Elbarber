defmodule ElbarberWeb.SessionController do
  use ElbarberWeb, :controller

  alias ElbarberWeb.SessionService

  import ElbarberWeb.PayloadValidator, except: [action: 2]

  plug :validate_payload, [required_fields: ["email", "password"]] when action in [:create]

  def create(conn, _params) do
    SessionService.authenticate_user(conn)
  end

end