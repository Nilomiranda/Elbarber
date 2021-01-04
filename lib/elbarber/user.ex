defmodule Elbarber.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Argon2


  # Use this to enable json parsing from the retrieved data
  @derive {Jason.Encoder, only: [:name, :email, :id, :inserted_at, :updated_at]}

  schema "users" do
    field :email, :string
    field :name, :string
    field :password_hash, :string
    timestamps()
  end

  def changeset(user, attrs) do
    hashed_password = add_hash(attrs["password"]).password_hash

    user
    |> cast(attrs, [:name, :email, :password_hash])
    |> validate_required([:name, :email, :password_hash])
    |> change(password_hash: hashed_password)
    |> unique_constraint(:email)
  end
end
