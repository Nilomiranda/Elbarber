defmodule ElbarberWeb.PayloadValidator do
  def validate_payload(required_fields, payload) do
    payload_keys = Map.keys payload

    if payload_keys !== required_fields do
      # returns missing required field
      required_fields -- payload_keys
    end
  end
end