defmodule Chatter.Message do
  use Ecto.Schema
  import Ecto.Changeset

  
  schema "messages" do
    field :name, :string
    field :message, :string

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

defimpl Poison.Encoder, for: Chatter.Message do
  def encode(model, opts) do
    model
    |> Map.take([:name, :message])
    |> Poison.Encoder.encode(opts)
  end
end