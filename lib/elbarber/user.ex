defmodule Elbarber.User do
  use Ecto.Schema
  import Ecto.Changeset

  # Use this to enable json parsing from the retrieved data
  @derive {Jason.Encoder, only: [:name, :email, :password_hash, :id, :inserted_at, :updated_at]}

  schema "users" do
    field :email, :string
    field :name, :string
    field :password_hash, :string
    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password_hash])
    |> validate_required([:name, :email, :password_hash])
    |> unique_constraint(:email)
  end
end
