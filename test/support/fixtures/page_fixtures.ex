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

      })
      |> ApiDisplay.Page.create_booking()

    booking
  end
end
