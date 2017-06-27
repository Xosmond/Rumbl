defmodule Rumbl.User do
  use Rumbl.Web, :model

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, [:name, :username, :password])
    |> validate_required([:name, :username])
    |> validate_length(:username, min: 3, max: 20)
  end

  schema "users" do
    field :name, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end
end
