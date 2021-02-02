defmodule ElbarberWeb.UserView do
  use ElbarberWeb, :view

  def render("index.json", %{users: users}) do
    IO.puts "CALLEd INDEX JSON"
    %{users: render_many(users, __MODULE__, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      created_at: user.inserted_at,
      updated_at: user.updated_at,
    }
  end

  def render(any_string, message) do
    IO.puts any_string
    IO.inspect message
    %{}
  end
end