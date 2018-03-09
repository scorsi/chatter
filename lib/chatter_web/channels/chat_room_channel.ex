defmodule ChatterWeb.ChatRoomChannel do
  use ChatterWeb, :channel

  def join("chat_room:lobby", payload, socket) do
    if authorized?(payload) do
      send(self(), :after_join)
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  def handle_in("shout", payload, socket) do
    spawn(fn -> save_msg(payload) end)
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  def handle_info(:after_join, socket) do
    Chatter.Message.get_msgs() 
    |> Enum.each(fn msg -> push(socket, "shout",
      %{
        name: msg.name,
        message: msg.message,
      }) end)
    {:noreply, socket}
  end

  defp save_msg(msg) do
    Chatter.Message.changeset(%Chatter.Message{}, msg)
    |> Chatter.Repo.insert
  end

  defp authorized?(_payload) do
    true
  end
end
