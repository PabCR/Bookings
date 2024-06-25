defmodule ApiDisplayWeb.BookingLive.Index do
  use ApiDisplayWeb, :live_view

  alias ApiDisplay.Page
  alias ApiDisplay.Page.Booking
  alias ApiDisplay.Syncer.Parse
  alias ApiDisplay.API.Caller

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :bookings, Page.list_bookings())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Booking")
    |> assign(:booking, Page.get_booking!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Booking")
    |> assign(:booking, %Booking{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Bookings")
    |> assign(:booking, nil)
  end

  @impl true
  def handle_info({ApiDisplayWeb.BookingLive.FormComponent, {:saved, booking}}, socket) do
    {:noreply, stream_insert(socket, :bookings, booking)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    booking = Page.get_booking!(id)
    {:ok, _} = Page.delete_booking(booking)

    {:noreply, stream_delete(socket, :bookings, booking)}
  end

  def handle_event("get_bookings", _value, socket) do
    (ApiDisplay.API.Caller.get_bookings("/productmgmt/api/api/searchbooking")
    |> Parse.json_to_map())[:bookings]
    |> Enum.each(fn [condition, content] ->
      # Create get by booking number method
      case condition do
        :updated ->
          {:noreply, stream_insert(socket, :bookings, content)}
        :created ->
          {:noreply, stream_insert(socket, :bookings, content)}
      end
    end)
  end
end
