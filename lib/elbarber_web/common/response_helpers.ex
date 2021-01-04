defmodule ElbarberWeb.ResponseHelpers do
  def remove_sensitive_fields(data, fields) do
    Map.drop(data, fields)
  end
end