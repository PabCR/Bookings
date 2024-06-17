defmodule ApiDisplay.Page.Booking do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bookings" do
    field :agent_number, :string
    field :arrival_date, :utc_datetime
    field :booking_number, :integer
    field :booking_status, :string
    field :booking_version, :integer
    field :change_time_stamp, :utc_datetime
    field :changed_by_initials, :string
    field :create_time_stamp, :utc_datetime
    field :creator_initials, :string
    field :currency_code, :string
    field :customer_number, :string
    field :departure_date, :utc_datetime
    field :email, :string
    field :external_booking_number, :string
    field :internal_reference, :string
    field :name, :string
    field :payment_method, :string
    field :payment_status, :integer
    field :payment_type, :string
    field :po_number, :string
    field :product_code, :string
    field :project_code, :string
    field :type, :string
    # field :name, :string
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(booking, attrs) do
    booking
    |> cast(attrs, [
      :agent_number,
      :arrival_date,
      :booking_number,
      :booking_status,
      :booking_version,
      :change_time_stamp,
      :changed_by_initials,
      :create_time_stamp,
      :creator_initials,
      :currency_code,
      :customer_number,
      :departure_date,
      :email,
      :external_booking_number,
      :internal_reference,
      :name,
      :payment_method,
      :payment_status,
      :payment_type,
      :po_number,
      :product_code,
      :project_code,
      :type
    ])
    |> validate_required([])
  end
end
