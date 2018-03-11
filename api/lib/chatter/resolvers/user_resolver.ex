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
        Accounts.create_user(args)
    end

    def update(%{id: id, user: params}, _info) do
        case Accounts.get_user(id) do
            nil -> {:error, "User id #{id} not found"}
            user -> Accounts.update_user(user, params)
        end
    end

    def delete(%{id: id}, _info) do
        case Accounts.get_user(id) do
            nil -> {:error, "User id #{id} not found"}
            user -> Accounts.delete_user(user)
        end
    end
end