defmodule ApiDisplay.Syncer.ParseTest do
  use ExUnit.Case
  alias ApiDisplay.Syncer.Parse
  alias ApiDisplay.Repo



  describe "json_to_map/1" do
#     test "returns processed bookings map on valid JSON" do
#       json = {:ok,
#       %{
#         "Bookings" => [
#           %{
#             "AgentNumber" => "string",
#             "ArrivalDate" => "2019-08-24T14:15:22Z",
#             "BookingNumber" => 0,
#             "BookingStatus" => "string",
#             "BookingVersion" => 0,
#             "ChangeTimeStamp" => "2019-08-24T14:15:22Z",
#             "ChangedByInitials" => "string",
#             "CreateTimeStamp" => "2019-08-24T14:15:22Z",
#             "CreatorInitials" => "string",
#             "CurrencyCode" => "string",
#             "CustomerNumber" => "string",
#             "DepartureDate" => "2019-08-24T14:15:22Z",
#             "Email" => "string",
#             "ExternalBookingNumber" => "string",
#             "InternalReference" => "string",
#             "Name" => "string",
#             "PaymentMethod" => "string",
#             "PaymentStatus" => 1,
#             "PaymentType" => "string",
#             "PoNumber" => "string",
#             "ProductCode" => "string",
#             "ProjectCode" => "string",
#             "Type" => "string"
#           }
#         ],
#         "TotalBookingsFound" => 1
#       }}

#       expected = %{
#   bookings: [
#     %ApiDisplay.Page.Booking{
#       id: 13,
#       agent_number: "string",
#       arrival_date: ~U[2019-08-24 14:15:22Z],
#       booking_number: 0,
#       booking_status: "string",
#       booking_version: 0,
#       change_time_stamp: ~U[2019-08-24 14:15:22Z],
#       changed_by_initials: "string",
#       create_time_stamp: ~U[2019-08-24 14:15:22Z],
#       creator_initials: "string",
#       currency_code: "string",
#       customer_number: "string",
#       departure_date: ~U[2019-08-24 14:15:22Z],
#       email: "string",
#       external_booking_number: "string",
#       internal_reference: "string",
#       name: "string",
#       payment_method: "string",
#       payment_status: 1,
#       payment_type: "string",
#       po_number: "string",
#       product_code: "string",
#       project_code: "string",
#       type: "string"
#     }
#   ],
#   total_bookings_found: 1
# }

#       assert Parse.json_to_map(json) == expected
#     end

    test "returns error tuple on JSON parsing error" do
      json = {:error, :invalid_json}
      assert Parse.json_to_map(json) == {:error, :invalid_json}
    end
  end
end
