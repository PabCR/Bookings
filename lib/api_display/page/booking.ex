defmodule ApiDisplay.Page.Booking do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bookings" do


    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(booking, attrs) do
    booking
    |> cast(attrs, [])
    |> validate_required([])
  end
end
