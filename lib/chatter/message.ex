defmodule Chatter.Message do
  use Ecto.Schema
  import Ecto.Changeset


  schema "messages" do
    field :message, :string
    field :name, :string

    timestamps()
  end

  def changeset(message, attrs) do
    message
    |> cast(attrs, [:name, :message])
    |> validate_required([:name, :message])
  end

  def get_msgs(limit \\ 20) do
    Chatter.Repo.all(Chatter.Message, limit: limit)
  end
end
