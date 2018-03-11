defmodule ChatterWeb.Schema do
    use Absinthe.Schema
    import_types ChatterWeb.Schema.Types

    input_object :update_user_params do
        field :username, non_null(:string)
        field :email, non_null(:string)
        field :password, :string
    end

    query do
        field :users, list_of(:user) do
            resolve &Chatter.UserResolver.all/2
        end

        field :user, type: :user do
            arg :id, non_null(:id)
            resolve &Chatter.UserResolver.find/2
        end
    end

    mutation do
        field :login, type: :session do
            arg :email, non_null(:string)
            arg :password, non_null(:string)
            resolve &Chatter.UserResolver.login/2
        end

        field :logout, type: :session do
            resolve &Chatter.UserResolver.logout/2
        end

        field :create_user, type: :user do
            arg :username, non_null(:string)
            arg :email, non_null(:string)
            arg :password, non_null(:string)
            resolve &Chatter.UserResolver.create/2
        end

        field :update_user, type: :user do
            arg :id, non_null(:integer)
            arg :user, non_null(:update_user_params)
            resolve &Chatter.UserResolver.update/2
        end

        field :delete_user, type: :user do
            arg :id, non_null(:integer)
            resolve &Chatter.UserResolver.delete/2
        end
    end
end