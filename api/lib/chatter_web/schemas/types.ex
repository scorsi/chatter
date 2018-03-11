defmodule ChatterWeb.Schema.Types do
    use Absinthe.Schema.Notation
    use Absinthe.Ecto, repo: Chatter.Repo

    object :user do
        field :id, :id
        field :username, :string
        field :email, :string
    end

    object :session do
        field :id, :id
        field :token, :string
    end
end