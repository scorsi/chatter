defmodule ChatterWeb.UserSocket do
  use Phoenix.Socket

  channel "chat_room:lobby", ChatterWeb.ChatRoomChannel

  transport :websocket, Phoenix.Transports.WebSocket

  def connect(_params, socket) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end
