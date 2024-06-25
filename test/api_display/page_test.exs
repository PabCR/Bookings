defmodule ApiDisplay.PageTest do
  use ApiDisplay.DataCase

  alias ApiDisplay.Page

  describe "bookings" do
    alias ApiDisplay.Page.Booking

    import ApiDisplay.PageFixtures

    @invalid_attrs %{:agent_number => nil, :arrival_date => ~D[2024-06-30]}
    @valid_attrs %{
      agent_number: "321",
      arrival_date: ~U[2024-06-30 17:50:08Z],
      booking_number: 1,
      booking_status: "canceled",
      booking_version: 1,
      change_time_stamp: ~U[2024-06-30 17:50:08Z],
      changed_by_initials: "AB",
      create_time_stamp: ~U[2024-06-30 17:50:08Z],
      creator_initials: "CD",
      currency_code: "USD",
      customer_number: "456",
      departure_date: ~U[2024-06-30 17:50:08Z],
      email: "valid@gmail.com",
      external_booking_number: "987",
      internal_reference: "010",
      name: "John Doe",
      payment_method: "credit card",
      payment_status: 1,
      payment_type: "credit",
      po_number: "2024",
      product_code: "2024",
      project_code: "2024",
      type: "booking"
    }

    test "list_bookings/0 returns all bookings" do
      booking = booking_fixture()
      assert Page.list_bookings() == [booking]
    end

    test "get_booking!/1 returns the booking with given id" do
      booking = booking_fixture()
      assert Page.get_booking!(booking.id) == booking
    end

    test "create_booking/1 with valid data creates a booking" do
      assert {:ok, %Booking{} = booking} = Page.create_booking(@valid_attrs)
    end

    test "create_booking/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Page.create_booking(@invalid_attrs)
    end

    test "update_booking/2 with valid data updates the booking" do
      booking = booking_fixture()
      update_attrs = @valid_attrs

      assert {:ok, %Booking{} = booking} = Page.update_booking(booking, update_attrs)
    end

    test "update_booking/2 with invalid data returns error changeset" do
      booking = booking_fixture()
      assert {:error, %Ecto.Changeset{}} = Page.update_booking(booking, @invalid_attrs)
      assert booking == Page.get_booking!(booking.id)
    end

    test "delete_booking/1 deletes the booking" do
      booking = booking_fixture()
      assert {:ok, %Booking{}} = Page.delete_booking(booking)
      assert_raise Ecto.NoResultsError, fn -> Page.get_booking!(booking.id) end
    end

    test "change_booking/1 returns a booking changeset" do
      booking = booking_fixture()
      assert %Ecto.Changeset{} = Page.change_booking(booking)
    end

    test "get_by_booking_number/1 returns the booking with given booking number" do
      booking = booking_fixture()
      assert Page.get_by_booking_number(booking.booking_number) == booking
    end
  end
end
