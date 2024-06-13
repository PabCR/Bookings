defmodule ApiDisplay.Repo.Migrations.CreateBookings do
  use Ecto.Migration

  def change do
    create table(:bookings) do
      timestamps(type: :utc_datetime)
    end
  end
end
