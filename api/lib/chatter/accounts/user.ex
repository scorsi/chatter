defmodule Chatter.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Chatter.Accounts.User
  alias Chatter.Repo

  schema "users" do
    field :email, :string, null: false
    field :username, :string, null: false
    field :token, :string
    field :password, :string, virtual: true
    field :password_hash, :string, null: false

    timestamps()
  end

  @doc """
  Authenticate the user with email and password.
  """
  def authenticate(params) do
    user = Repo.get_by(User, email: String.downcase(params.email))
    case check_password(user, params.password) do
      true -> {:ok, user}
      false -> {:error, "Incorrect login credentials"}
    end
  end

  @doc """
  Check given password with password_hash of the given user
  """
  def check_password(user, password) do
    case user do
      nil -> false
      _ -> Comeonin.Bcrypt.checkpw(password, user.password_hash)
    end
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email])
    |> validate_required([:username, :email])
    |> unique_constraint(:username)
    |> unique_constraint(:email)
  end

  @doc false
  def registration_changeset(user, attrs) do
    user
    |> changeset(attrs)
    |> cast(attrs, [:password])
    |> validate_required([:password])
    |> validate_length(:password, min: 6, max: 100)
    |> put_password_hash()
  end

  @doc false
  def store_token_changeset(user, attrs) do
    user
    |> cast(attrs, [:token])
    |> validate_required([:token])
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(password))
      _ -> changeset
    end
  end
end
