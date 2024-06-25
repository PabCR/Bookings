defmodule ApiDisplay.PageFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ApiDisplay.Page` context.
  """

  @doc """
  Generate a booking.
  """
  def booking_fixture(attrs \\ %{}) do
    {:ok, booking} =
      attrs
      |> Enum.into(%{
        agent_number: "123",
        arrival_date: ~U[2024-06-13 17:50:08Z],
        booking_number: 1,
        booking_status: "confirmed",
        booking_version: 1,
        change_time_stamp: ~U[2024-06-13 17:50:08Z],
        changed_by_initials: "AB",
        create_time_stamp: ~U[2024-06-13 17:50:08Z],
        creator_initials: "CD",
        currency_code: "USD",
        customer_number: "456",
        departure_date: ~U[2024-06-13 17:50:08Z],
        email: "deez@gmail.com",
        external_booking_number: "789",
        internal_reference: "101",
        name: "John Doe",
        payment_method: "credit card",
        payment_status: 1,
        payment_type: "credit",
        po_number: "2024",
        product_code: "2024",
        project_code: "2024",
        type: "booking"
      })
      |> ApiDisplay.Page.create_booking()

    booking
  end
end
