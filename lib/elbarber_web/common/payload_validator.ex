defmodule ElbarberWeb.PayloadValidator do
  use ElbarberWeb, :controller
  import Plug.Conn

  def validate_payload(conn, options) do
    payload_keys = Map.keys conn.body_params
    required_fields = options[:required_fields]

      # returns missing required field
      missing_fields = required_fields -- payload_keys

      if length(missing_fields) > 0 do
        conn
        |> put_status(400)
        |> halt()
        |> json(%{:error => "MISSING_REQUIRED_FIELD", :message => "Field #{hd(missing_fields)} is required"})
      end
    conn
  end
end