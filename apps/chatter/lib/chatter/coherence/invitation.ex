defmodule Chatter.Coherence.Invitation do
  use Ecto.Schema
  import Ecto.Changeset

  

  schema "invitations" do
    field :name, :string
    field :email, :string
    field :token, :string

    timestamps()
  end

  @spec changeset(Ecto.Schema.t, Map.t) :: Ecto.Changeset.t
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, ~w(name email token))
    |> validate_required([:name, :email])
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
  end

  @spec new_changeset(Map.t) :: Ecto.Changeset.t
  def new_changeset(params \\ %{}) do
    changeset %__MODULE__{}, params
  end
end
