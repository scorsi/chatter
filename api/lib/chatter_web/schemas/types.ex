defmodule ChatterWeb.Schema.Types do
    use Absinthe.Schema.Notation
    use Absinthe.Ecto, repo: Chatter.Repo

    object :user do
        field :id, :id
        field :name, :string
        field :email, :string
    end
end