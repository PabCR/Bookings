defmodule ApiDisplay.Repo.Migrations.BookingsTable do
  use Ecto.Migration

  def change do
    create table(:bookings_table) do
      add :agent_number, :string
      add :arrival_date, :date
      add :booking_number, :integer
      add :booking_status, :string
      add :booking_version, :integer
      add :change_time_stamp, :utc_datetime
      add :changed_by_initials, :string
      add :create_time_stamp, :utc_datetime
      add :creator_initials, :string
      add :currency_code, :string
      add :customer_number, :string
      add :departure_date, :date
      add :email, :string
      add :external_booking_number, :string
      add :internal_reference, :string
      add :name, :string
      add :payment_method, :string
      add :payment_status, :integer
      add :payment_type, :string
      add :po_number, :string
      add :product_code, :string
      add :project_code, :string
      add :type, :string

      timestamps(type: :utc_datetime)
    end
  end
end
