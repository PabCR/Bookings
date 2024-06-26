defmodule ApiDisplayWeb.BookingLive.FormComponent do
  use ApiDisplayWeb, :live_component

  alias ApiDisplay.Page

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage booking records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="booking-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input type="text" field={@form[:agent_number]} label="Agent Number" />
        <.input type="datetime-local" field={@form[:arrival_date]} label="Arrival Date" />
        <.input type="number" field={@form[:booking_number]} label="Booking Number" />
        <.input type="text" field={@form[:booking_status]} label="Booking Status" />
        <.input type="number" field={@form[:booking_version]} label="Booking Version" />
        <.input type="datetime-local" field={@form[:change_time_stamp]} label="Change Time Stamp" />
        <.input type="text" field={@form[:changed_by_initials]} label="Changed By Initials" />
        <.input type="datetime-local" field={@form[:create_time_stamp]} label="Create Time Stamp" />
        <.input type="text" field={@form[:creator_initials]} label="Creator Initials" />
        <.input type="text" field={@form[:currency_code]} label="Currency Code" />
        <.input type="text" field={@form[:customer_number]} label="Customer Number" />
        <.input type="datetime-local" field={@form[:departure_date]} label="Departure Date" />
        <.input type="email" field={@form[:email]} label="Email" />
        <.input type="text" field={@form[:external_booking_number]} label="External Booking Number" />
        <.input type="text" field={@form[:internal_reference]} label="Internal Reference" />
        <.input type="text" field={@form[:name]} label="Name" />
        <.input type="text" field={@form[:payment_method]} label="Payment Method" />
        <.input type="number" field={@form[:payment_status]} label="Payment Status" />
        <.input type="text" field={@form[:payment_type]} label="Payment Type" />
        <.input type="text" field={@form[:po_number]} label="PO Number" />
        <.input type="text" field={@form[:product_code]} label="Product Code" />
        <.input type="text" field={@form[:project_code]} label="Project Code" />
        <.input type="text" field={@form[:type]} label="Type" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Booking</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{booking: booking} = assigns, socket) do
    changeset = Page.change_booking(booking)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"booking" => booking_params}, socket) do
    changeset =
      socket.assigns.booking
      |> Page.change_booking(booking_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"booking" => booking_params}, socket) do
    save_booking(socket, socket.assigns.action, booking_params)
  end

  defp save_booking(socket, :edit, booking_params) do
    case Page.update_booking(socket.assigns.booking, booking_params) do
      {:ok, booking} ->
        notify_parent({:saved, booking})

        {:noreply,
         socket
         |> put_flash(:info, "Booking updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_booking(socket, :new, booking_params) do
    case Page.create_booking(booking_params) do
      {:ok, booking} ->
        notify_parent({:saved, booking})

        {:noreply,
         socket
         |> put_flash(:info, "Booking created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
