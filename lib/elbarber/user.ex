defmodule Elbarber.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Argon2


  # Use this to enable json parsing from the retrieved data
  @derive {Jason.Encoder, only: [:name, :email, :id, :inserted_at, :updated_at]}

  schema "users" do
    field :email, :string
    field :name, :string
    field :password_hash, :string, load_in_query: false
    field :password, :string, virtual: true
    timestamps()
  end

  def changeset(user, attrs) do
    hashed_password = add_hash(attrs["password"]).password_hash

    IO.puts "USER DATA"
    IO.inspect attrs
    IO.inspect attrs["password"]

    user
    |> cast(attrs, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
    |> change(password_hash: hashed_password)
    |> unique_constraint(:email)
  end
end
