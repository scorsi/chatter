defmodule Chatter.UserResolver do
    alias Chatter.Accounts

    def all(_args, _info) do
        {:ok, Accounts.list_users()}
    end
    
    def find(%{id: id}, _info) do
        case Accounts.get_user(id) do
            nil -> {:error, "User id #{id} not found"}
            user -> {:ok, user}
        end
    end

    def create(args, _info) do
        case Accounts.create_user(args) do
            {:ok, user} -> {:ok, user}
            {:error, changeset} -> {:error, ChatterWeb.EctoHelper.pretty_errors(changeset.errors)}
        end
    end

    def update(%{id: id, user: params}, _info) do
        case Accounts.get_user(id) do
            nil -> {:error, "User id #{id} not found"}
            user -> 
                case Accounts.update_user(user, params) do
                    {:ok, user} -> {:ok, user}
                    {:error, changeset} -> {:error, ChatterWeb.EctoHelper.pretty_errors(changeset.errors)}
                end
        end
    end

    def delete(%{id: id}, _info) do
        case Accounts.get_user(id) do
            nil -> {:error, "User id #{id} not found"}
            user ->
                case Accounts.delete_user(user) do
                    {:ok, user} -> {:ok, user}
                    {:error, changeset} -> {:error, ChatterWeb.EctoHelper.pretty_errors(changeset.errors)}
                end
        end
    end

    def login(params, _info) do
        with {:ok, user} <- Chatter.Accounts.User.authenticate(params),
            {:ok, token, _} <- Chatter.Guardian.encode_and_sign(user),
            {:ok, _} <- Chatter.Accounts.store_user(user, token)
        do
            {:ok, %{id: user.id, token: token}}
        end
    end

    def logout(_params, info) do
        case Map.has_key?(info.context, :token) do
            false -> {:error, "Not logged in"}
            true ->
                token = info.context.token
                Chatter.Guardian.revoke(token)
                {:ok, %{id: info.context.current_user.id, token: token}}
        end
    end
end