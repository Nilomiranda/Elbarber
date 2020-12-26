defmodule ElbarberWeb.PageController do
  use ElbarberWeb, :controller

  def index(conn, _params) do
    json(conn, %{:online => true})
  end
end
