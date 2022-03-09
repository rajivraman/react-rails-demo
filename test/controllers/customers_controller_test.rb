require "test_helper"

class CustomersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get customers_index_url
    assert_response :success
  end

  test "should fail post upload - missing data" do
    post customers_upload_url
    assert_response :success
    res = JSON.parse(@response.body)
    assert_equal "Please select a file and sort type.", res["error"]
  end

  test "should post upload - comma-delimited, vehicle_type sort" do
    data_file = fixture_file_upload('commas.txt','text/plain')
    post customers_upload_url, params: {file: data_file, sort: "vehicle_type"}
    assert_response :success
    res = JSON.parse(@response.body)
    assert_equal "campervan", res["results"][0]["vehicleType"]
    assert_equal "motorboat", res["results"][1]["vehicleType"]
    assert_equal "sailboat", res["results"][2]["vehicleType"]
    assert_equal "sailboat", res["results"][3]["vehicleType"]
  end

  test "should post upload - comma-delimited, full_name sort" do
    data_file = fixture_file_upload('commas.txt','text/plain')
    post customers_upload_url, params: {file: data_file, sort: "full_name"}
    assert_response :success
    res = JSON.parse(@response.body)
    assert_equal "Buffet", res["results"][0]["lastName"]
    assert_equal "Martinez", res["results"][1]["lastName"]
    assert_equal "Singh Soin", res["results"][2]["lastName"]
    assert_equal "Thunberg", res["results"][3]["lastName"]
  end

  test "should post upload - pipe-delimited, vehicle_type sort" do
    data_file = fixture_file_upload('pipes.txt','text/plain')
    post customers_upload_url, params: {file: data_file, sort: "vehicle_type"}
    assert_response :success
    res = JSON.parse(@response.body)
    assert_equal "bicycle", res["results"][0]["vehicleType"]
    assert_equal "campervan", res["results"][1]["vehicleType"]
    assert_equal "motorboat", res["results"][2]["vehicleType"]
    assert_equal "RV", res["results"][3]["vehicleType"]
  end

  test "should post upload - pipe-delimited, full_name sort" do
    data_file = fixture_file_upload('pipes.txt','text/plain')
    post customers_upload_url, params: {file: data_file, sort: "full_name"}
    assert_response :success
    res = JSON.parse(@response.body)
    assert_equal "Adams", res["results"][0]["lastName"]
    assert_equal "Ceesay", res["results"][1]["lastName"]
    assert_equal "Irwin", res["results"][2]["lastName"]
    assert_equal "Uemura", res["results"][3]["lastName"]
  end
end
