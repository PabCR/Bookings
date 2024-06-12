defmodule ApiDisplay.PageTest do
  use ApiDisplay.DataCase

  alias ApiDisplay.Page

  describe "bookings" do
    alias ApiDisplay.Page.Booking

    import ApiDisplay.PageFixtures

    @invalid_attrs %{}

    test "list_bookings/0 returns all bookings" do
      booking = booking_fixture()
      assert Page.list_bookings() == [booking]
    end

    test "get_booking!/1 returns the booking with given id" do
      booking = booking_fixture()
      assert Page.get_booking!(booking.id) == booking
    end

    test "create_booking/1 with valid data creates a booking" do
      valid_attrs = %{}

      assert {:ok, %Booking{} = booking} = Page.create_booking(valid_attrs)
    end

    test "create_booking/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Page.create_booking(@invalid_attrs)
    end

    test "update_booking/2 with valid data updates the booking" do
      booking = booking_fixture()
      update_attrs = %{}

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
  end
end
