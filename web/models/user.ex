defmodule Rumbl.User do
  use Rumbl.Web, :model

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, [:name, :username, :password]) # Allowed values
    |> validate_required([:name, :username]) # Required values
    |> validate_length(:username, min: 3, max: 20) # Required values
  end

  def registration_changeset(model, params) do
    model
    |> changeset(params)
    |> cast(params, [:password])
    |> validate_required([:password])
    |> validate_length(:password, min: 6, max: 100)
    |> put_password_hash()
  end

  def put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset {valid?: true, changes: %{password: password }} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
        changeset
    end
  end

  schema "users" do
    field :name, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    has_many :videos, Rumbl.Video

    timestamps()
  end
end
