defmodule ChatterWeb.RoomChannel do
  use ChatterWeb, :channel

  intercept ["message:new"]

  def join("room:lobby", payload, socket) do
    if authorized?(payload) do
      # send(self(), :after_join)
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in("message:new", %{"body" => body}, socket) do
    # user = Chatter.Coherence.Schemas.get_user(socket.assigns.user_id)
    broadcast!(socket, "message:new", %{
      # user: user.name, 
      body: body
    })
    {:noreply, socket}
  end

  def handle_out("message:new", payload, socket) do
    push(socket, "message:new", payload)
    {:noreply, socket}
  end

  # def handle_info(:after_join, socket) do
  #   user = Chatter.Coherence.Schemas.get_user(socket.assigns.user_id)
  #   {:ok, _} = ChatterWeb.Presence.track(socket, user.name, %{
  #     online_at: inspect(System.system_time(:seconds))
  #   })
  #   push socket, "presence_state", ChatterWeb.Presence.list(socket)
  #   {:noreply, socket}
  # end

  defp authorized?(_payload) do
    true
  end
end
