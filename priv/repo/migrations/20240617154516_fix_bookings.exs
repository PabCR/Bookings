defmodule ApiDisplay.Repo.Migrations.FixBookings do
  use Ecto.Migration

  def change do
    drop table("bookings")
    rename table("bookings_table"), to: table("bookings")
  end
end
