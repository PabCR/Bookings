defmodule ApiDisplayWeb.BookingLiveTest do
  use ApiDisplayWeb.ConnCase

  import Phoenix.LiveViewTest
  import ApiDisplay.PageFixtures

  @create_attrs %{
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
  }
  @update_attrs %{
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
  @invalid_attrs %{:agent_number => nil, :arrival_date => ~D[2024-06-30]}

  defp create_booking(_) do
    booking = booking_fixture()
    %{booking: booking}
  end

  describe "Index" do
    setup [:create_booking]

    test "lists all bookings", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/bookings")

      assert html =~ "Listing Bookings"
    end

    test "saves new booking", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/bookings")

      assert index_live |> element("a", "New Booking") |> render_click() =~
               "New Booking"

      assert_patch(index_live, ~p"/bookings/new")

      # assert index_live
      #        |> form("#booking-form", booking: @invalid_attrs)
      #        |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#booking-form", booking: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/bookings")

      html = render(index_live)
      assert html =~ "Booking created successfully"
    end

    test "updates booking in listing", %{conn: conn, booking: booking} do
      {:ok, index_live, _html} = live(conn, ~p"/bookings")

      assert index_live |> element("#bookings-#{booking.id} a", "Edit") |> render_click() =~
               "Edit Booking"

      assert_patch(index_live, ~p"/bookings/#{booking}/edit")

      # assert index_live
      #        |> form("#booking-form", booking: @invalid_attrs)
      #        |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#booking-form", booking: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/bookings")

      html = render(index_live)
      assert html =~ "Booking updated successfully"
    end

    test "deletes booking in listing", %{conn: conn, booking: booking} do
      {:ok, index_live, _html} = live(conn, ~p"/bookings")

      assert index_live |> element("#bookings-#{booking.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#bookings-#{booking.id}")
    end
  end

  describe "Show" do
    setup [:create_booking]

    test "displays booking", %{conn: conn, booking: booking} do
      {:ok, _show_live, html} = live(conn, ~p"/bookings/#{booking}")

      assert html =~ "Show Booking"
    end

    test "updates booking within modal", %{conn: conn, booking: booking} do
      {:ok, show_live, _html} = live(conn, ~p"/bookings/#{booking}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Booking"

      assert_patch(show_live, ~p"/bookings/#{booking}/show/edit")

      # assert show_live
      #        |> form("#booking-form", booking: @invalid_attrs)
      #        |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#booking-form", booking: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/bookings/#{booking}")

      html = render(show_live)
      assert html =~ "Booking updated successfully"
    end
  end
end
