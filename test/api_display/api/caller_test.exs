defmodule CallerTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  alias ApiDisplay.API.Caller

  doctest Caller

  setup do
    ExVCR.Config.cassette_library_dir("test/fixture/vcr_cassettes")
    :ok
  end

  describe "get_bookings/1" do
    test "returns {:ok, _} from valid url" do
      use_cassette "get_bookings_valid_url" do
        assert {:ok, _} = Caller.get_bookings("/productmgmt/api/api/searchbooking")
      end
    end

    test "returns not_found from invalid url" do
      use_cassette "get_bookings_invalid_url" do
        assert {:not_found, _} = Caller.get_bookings("/axproductmgmt/api/api/searchbooking")
      end
    end

    test "returns error from invalid url" do
      use_cassette "get_bookings_error_url" do
        assert {:error, _} = Caller.get_bookings("some_invalid_url")
      end
    end
  end
end
