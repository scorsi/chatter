defmodule ChatterWeb.UserSocket do
  use Phoenix.Socket

  channel "room:*", ChatterWeb.RoomChannel

  transport :websocket, Phoenix.Transports.WebSocket

  # def connect(%{"token" => user_id_token}, socket) do
  #   case Phoenix.Token.verify(socket, "user_id", user_id_token, max_age: 1000000) do
  #     {:ok, user_id} ->
  #       {:ok, assign(socket, :user_id, user_id)}
  #     {:error, _reason} ->
  #       :error
  #   end
  # end
  
  def connect(_params, socket) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end
