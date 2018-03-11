defmodule Chatter.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :email, :string, null: false
    field :name, :string, null: false
    field :password, :string, virtual: true
    field :password_hash, :string, null: false

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
  end

  @doc false
  def update_changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email], [:password])
    |> validate_required([:name, :email])
    |> put_pass_hash()
  end

  @doc false
  def registration_changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
    |> put_pass_hash()
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(password))
      _ -> changeset
    end
  end
end
