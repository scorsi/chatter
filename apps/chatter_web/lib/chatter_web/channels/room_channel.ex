defmodule ChatterWeb.RoomChannel do
  use ChatterWeb, :channel

  def join("room:lobby", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  def handle_in("message:new", payload, socket) do
    user = Chatter.Coherence.Schemas.get_user(socket.assigns.user_id)
    broadcast(socket, "message:new", %{
      user: user.name, 
      message: payload["message"]
    })
    {:noreply, socket}
  end

  defp authorized?(_payload) do
    true
  end
end
