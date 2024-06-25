defmodule ApiDisplay.Syncer.Parse do
  def json_to_map(json) do
    case json do
      {:ok, data} -> process_bookings(data)
      {:error, reason} -> {:error, reason}
    end
  end

  defp process_bookings(%{"TotalBookingsFound" => total_bookings, "Bookings" => bookings}) do
    %{
      total_bookings_found: total_bookings,
      bookings: Enum.map(bookings, &process_booking/1)
    }
  end

  defp process_booking(booking) do
    snake_case_booking = %{
      booking_number: booking["BookingNumber"],
      departure_date: booking["DepartureDate"],
      arrival_date: booking["ArrivalDate"],
      internal_reference: booking["InternalReference"],
      external_booking_number: booking["ExternalBookingNumber"],
      create_time_stamp: booking["CreateTimeStamp"],
      booking_status: booking["BookingStatus"],
      agent_number: booking["AgentNumber"],
      customer_number: booking["CustomerNumber"],
      change_time_stamp: booking["ChangeTimeStamp"],
      type: booking["Type"],
      name: booking["Name"],
      payment_status: booking["PaymentStatus"],
      booking_version: booking["BookingVersion"],
      project_code: booking["ProjectCode"],
      email: booking["Email"],
      currency_code: booking["CurrencyCode"],
      product_code: booking["ProductCode"],
      payment_method: booking["PaymentMethod"],
      payment_type: booking["PaymentType"],
      creator_initials: booking["CreatorInitials"],
      changed_by_initials: booking["ChangedByInitials"],
      po_number: booking["PoNumber"]
    }

    case(ApiDisplay.Page.get_by_booking_number(snake_case_booking[:booking_number])) do
      nil ->
        {_message, booking} = ApiDisplay.Page.create_booking(snake_case_booking)
        booking

      existing_booking ->
        {_message, booking} = ApiDisplay.Page.update_booking(existing_booking, snake_case_booking)
        booking
    end
  end
end
